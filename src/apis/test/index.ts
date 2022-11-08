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
};
