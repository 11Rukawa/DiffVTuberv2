import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    include: ['tests/**/*.test.ts'],
    env: { DIFF_VTUBERV2_LANGUAGE: 'zh' },
    testTimeout: 20000,
    pool: 'forks',
  },
});
