import { service } from "../apiConfig";

export default {
  jobTest(data: any) {
    return service({
      url: "/api/modeljson",
      method: "post",
      data: data,
    });
  },
  healthTest() {
    return service({
      url: "/health",
      method: "get",
    });
  },
  WebSocketsTest2() {
    return service({
      url: "/foo/car",
      method: "get",
    });
  },
};
