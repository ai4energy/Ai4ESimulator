import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  json: {
    namedExports: true,
    stringify: false,
  },
  envDir: "./env",
  envPrefix: "VITE_", // default
  server: {
    host: true,
    port: 9528,
    strictPort: false,
    https: false,
    open: true,
    proxy: {
      "/api": {
        target: "http://121.40.92.145:8081",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
    },
    cors: false,
  },
  build: {
    minify: true, // boolean | 'terser' | 'esbuild', defaut to terser
    manifest: false, // whether maifest.json
    sourcemap: false, // whether soucemap.json
    outDir: "build", // output dir
  },
});
