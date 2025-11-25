// src/plugins/globalComponents.js
import IconCircleCheck from "@/components/icons/IconCircleCheck.vue";
import IconExternalLink from "@/components/icons/IconExternalLink.vue";

export default {
  install: (app) => {
    app.component("IconCircleCheck", IconCircleCheck);
    app.component("IconExternalLink", IconExternalLink);
  },
};
