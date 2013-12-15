#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "keybinder.h"

void kb_test(){
  printf("Hello KB\n");
}

MODULE = Keybinder		PACKAGE = Keybinder		

void
kb_test()

gboolean
keybinder_bind(keystring, handler, user_data)
  const char *keystring
  KeybinderHandler handler
  void *user_data
  PROTOTYPE: $$$

BOOT:
  keybinder_init();

