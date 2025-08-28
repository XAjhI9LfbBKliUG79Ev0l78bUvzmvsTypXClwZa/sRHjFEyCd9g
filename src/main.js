import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";

import "./assets/base.css";

import IconCircleCheck from "@/components/icons/IconCircleCheck.vue";
import IconExternalLink from "@/components/icons/IconExternalLink.vue";

const app = createApp(App);

app.component("IconCircleCheck", IconCircleCheck);
app.component("IconExternalLink", IconExternalLink);

app.use(router);

app.mount("#app");
