import axios, { type AxiosInstance } from "axios";

// 创建axios实例
const service: AxiosInstance = axios.create({
  baseURL: import.meta.env.VITE_DEV_API_URL,
  // baseURL: "/api",
  timeout: 500000,
});

service.interceptors.request.use(
  (config) => {
    /* if (store.getters.token) {
      config.headers["Authorization"] = "Bearer " + getToken();
    } */
    config.headers['Content-Type'] = "application/json";
    return config;
  },
  (error) => {
    if (import.meta.env.Dev) console.error("Err: " + error.toString()); // for debug
    window.$message.error("Message failed!");
    return Promise.reject(error);
  }
);

service.interceptors.response.use(
  (response) => {
    if (response.status !== 200) {
      window.$message.error("Request failed with " + response.status);
      return Promise.reject("Error with code: " + response.status);
    } else {
      // window.$message.success("请转到绘图页查看结果" + response.statusText);
      window.$message.success("请转到绘图页查看结果！");
      return response.data;
    }
  },
  (error) => {
    if (import.meta.env.Dev) console.error("Err: " + error.toString()); // for debug
    window.$message.error("Message failed!");
    return Promise.reject(error);
  }
);

export { service };
