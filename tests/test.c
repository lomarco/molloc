#include <molloc.h>

#define DYN_SIZE 4096

int main(void) {
  int *dyn = (int *)molloc(DYN_SIZE);

  // do somethink...

  free(dyn);
}
