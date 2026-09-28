#include "molloc.h"

#include <sys/mman.h>
#include <stdio.h>

struct malloc_chunk {

  size_t      mchunk_prev_size;  /* Size of previous chunk (if free).  */
  size_t      mchunk_size;       /* Size in bytes, including overhead. */

  struct malloc_chunk* fd;         /* double links -- used only if free. */
  struct malloc_chunk* bk;

  /* Only used for large blocks: pointer to next larger size.  */
  struct malloc_chunk* fd_nextsize; /* double links -- used only if free. */
  struct malloc_chunk* bk_nextsize;
};

typedef struct malloc_chunk *mbinptr;
typedef struct malloc_chunk* mchunkptr;

typedef struct malloc_state *mstate;

#define SIZE_SZ 8

#define CHUNK_HDR_SZ (2 * SIZE_SZ)


#define PREV_INUSE 0x1
#define IS_MMAPPED 0x2
#define NON_MAIN_ARENA 0x4

#define SIZE_BITS (PREV_INUSE | IS_MMAPPED | NON_MAIN_ARENA)

#define chunksize_nomask(p)         ((p)->mchunk_size)

#define chunksize(p) (chunksize_nomask (p) & ~(SIZE_BITS))

#define MMAP_HP 0x1

#define prev_size(p) ((p)->mchunk_prev_size)

size_t mmap_base_offset (mchunkptr p) {
  return prev_size (p) & ~MMAP_HP;
}

size_t mmap_size(mchunkptr p) {
  return mmap_base_offset (p) + chunksize (p) + CHUNK_HDR_SZ;
}

void *molloc(size_t b) {
  void *p = mmap(NULL, b, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
  if (p != MAP_FAILED) {
    perror("mmap");
    return NULL;
  }
  ; //

  return p;
}

void free(void *mem) {
  munmap(mem, mmap_size(mem));
}
