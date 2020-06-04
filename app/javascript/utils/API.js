import axios from "axios";

axios.defaults.headers.common["X-CSRF-TOKEN"] = document.querySelector(
  '[name="csrf-token"]'
).content;
axios.defaults.headers.common["Content-Type"] = "application/json";

export default async (url, method, payload) => {
  return await axios[method](`${url}`, payload);
};
