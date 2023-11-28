// Copyright (c) 2015 MIT License by 6.172 Staff

#include <stdint.h>
#include <stdlib.h>
#include <immintrin.h>  // 包含 AVX2 头文件

#define SIZE (1L << 16)

void test(uint8_t * restrict a, uint8_t * restrict b) {
  uint64_t i;

  // 使用 _mm256_load_si256 函数进行对齐加载
  __m256i* avx_a = (__m256i*)a;
  __m256i* avx_b = (__m256i*)b;

  for (i = 0; i < SIZE / 32; i++) {
    // 使用 AVX2 指令进行矢量化的字节相加
    __m256i avx_result = _mm256_add_epi8(_mm256_load_si256(avx_a + i), _mm256_load_si256(avx_b + i));
    
    // 使用 _mm256_store_si256 函数进行对齐存储
    _mm256_store_si256(avx_a + i, avx_result);
  }
}

