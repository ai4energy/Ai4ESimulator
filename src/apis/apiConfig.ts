import axios, { type AxiosInstance } from "axios";

// 创建axios实例
const service: AxiosInstance = axios.create({
  baseURL: import.meta.env.VITE_DEV_API,
  timeout: 5000,
});

service.interceptors.request.use(
  (config) => {
    /* if (store.getters.token) {
      config.headers["Authorization"] = "Bearer " + getToken();
    } */
    return config;
  },
  (error) => {
    if (import.meta.env.Dev) console.error("Err: " + error.toString()); // for debug
    window.$msg.error("Message failed!");
    return Promise.reject(error);
  }
);

service.interceptors.response.use(
  (response) => {
    if (response.status !== 200) {
      window.$msg.error("Request failed with " + response.status);
      return Promise.reject("Error with code: " + response.status);
    } else {
      window.$msg.success("Request success with " + response.statusText);
      return response.data;
    }
  },
  (error) => {
    if (import.meta.env.Dev) console.error("Err: " + error.toString()); // for debug
    window.$msg.error("Message failed!");
    return Promise.reject(error);
  }
);

export { service };
