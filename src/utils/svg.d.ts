export declare interface ISvgElement {
  tag: string;
  props: Any;
  childern?: Array<ISvgElement>;
}

export declare class SvgGrop implements ISvgElement {
  tag: string;
  props: {
    transform?: string;
    style?: {
      visibility?: string;
      cursor?: strng;
    };
  };
  childern: Array<ISvgElement>;
}

export declare class SvgEllipse implements ISvgElement {
  tag: string;
  props: {
    cx: number;
    cy: number;
    rx: number;
    ry: number;
    fill: string;
    stroke: string;
    ["pointer-events"]: string;
  };
}

export declare class SvgPath implements ISvgElement {
  tag: string;
  props: {
    d: string;
    fill: string;
    stroke: string;
    ["pointer-events"]: string;
    ["stroke-miterlimit"]: number;
  };
}

export declare interface ISvgIcon {
  guid: string;
  title: {
    zhcn: string;
    enus: string;
  };
  size: {
    width: number;
    height: number;
    locked: boolean;
  };
  angle: number;
  color: {
    edge: string;
    fill: string;
  };
  position: {
    x: number;
    y: number;
  };
  icon: Array<ISvgElement>;
}
