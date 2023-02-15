import axios, { Axios } from "axios";
import { service } from "../apiConfig";

export default {
  jobTest(data: any) {
    return service({
      url: "/job",
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
  WebSocketsTest() {
    return service({
      url: "/foo/bar",
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
