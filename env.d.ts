/// <reference types="vite/client" />
import type { MessageApi } from "naive-ui";
export declare global {
  interface Window {
    $msg: MessageApi;
  }
}
