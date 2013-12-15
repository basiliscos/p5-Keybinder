#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "keybinder.h"

void kb_test(){
  printf("Hello KB\n");
}


gboolean bind_key(const char *keystring, KeybinderHandler cb){
  SvREFCNT_inc(cb);
  gboolean could_be_grabbed
    = keybinder_bind(keystring, cb, NULL);
  if(!could_be_grabbed) SvREFCNT_dec(cb);
  return could_be_grabbed;
}


void unbind_key(const char *keystring, KeybinderHandler cb){
  keybinder_unbind(keystring, cb);
  SvREFCNT_dec(cb);
}


MODULE = Keybinder		PACKAGE = Keybinder		

void
kb_test()

gboolean
bind_key(keystring, cb)
  const char *keystring
  KeybinderHandler cb
  PROTOTYPE: $$

void
unbind_key(keystring, cb)
  const char *keystring
  KeybinderHandler cb


BOOT:
  keybinder_init();

