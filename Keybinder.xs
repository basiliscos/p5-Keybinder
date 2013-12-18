#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "keybinder.h"

static HV * cb_mapping = (HV*)NULL;

void kb_test(){
  printf("Hello KB\n");
}


void callback_bridge(const char *keystring, void *user_data){
  dSP;
  SV** cb = hv_fetch(cb_mapping, (char*)user_data, sizeof(void*), 0);
  if (cb == (SV**)NULL)
    croak("Internal error: no callback can't be found\n");
  printf("callback_bridge for %s\n", keystring);
  PUSHMARK(SP);
  call_sv(*cb, G_NOARGS|G_DISCARD|G_VOID);
}


gboolean bind_key(const char *keystring, SV* cb){
  SvGETMAGIC(cb);
  if(!SvROK(cb)
     || (SvTYPE(SvRV(cb)) != SVt_PVCV))
  {
    croak("Second argument for bind_key should be a closure...\n");
  }
  SV* cb_copy = newSVsv(cb);
  gboolean success = keybinder_bind(keystring, callback_bridge, (void*) cb_copy);
  if ( success ) {
    hv_store(cb_mapping, (char*)cb_copy, sizeof(void*), cb_copy, 0);
  }
  else {
    SvREFCNT_dec(cb_copy);
  }

  return success;
}


void unbind_key(const char *keystring, SV* cb){
  SV** cb_copy = hv_delete(cb_mapping, (char*)cb, sizeof(void*), 0);
  if ( cb_copy ) {
    keybinder_unbind(keystring, callback_bridge);
  }
}


MODULE = Keybinder		PACKAGE = Keybinder		

BOOT:
  keybinder_init();
  cb_mapping = newHV();

void
kb_test()

gboolean
bind_key(keystring, cb)
  const char *keystring
  SV* cb
  PROTOTYPE: $$

void
unbind_key(keystring, cb)
  const char *keystring
  SV* cb
  PROTOTYPE: $$



