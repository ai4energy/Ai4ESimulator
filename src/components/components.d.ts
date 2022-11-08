import type { ISvgIcon } from "@/utils/svg";

export declare interface IPanelItem {
  title: {
    zhcn: string;
    enus: string;
  };
  state?: boolean;
  index?: number;
  icons: Array<ISvgIcon>;
}
