import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import { useSmoothScroll } from "../composables/useSmoothScroll.js";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
      meta: { title: "Адвокат Шкода Алексей Игоревич" },
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    const { getHeaderHeight } = useSmoothScroll();

    if (savedPosition) {
      return savedPosition;
    } else if (to.hash) {
      return new Promise((resolve) => {
        const element = document.querySelector(to.hash);
        if (element) {
          const headerOffset = getHeaderHeight();
          const elementPosition = element.getBoundingClientRect().top;
          const offsetPosition =
            elementPosition + window.pageYOffset - headerOffset;

          resolve({ top: offsetPosition, behavior: "smooth" });
        } else {
          resolve({ top: 0 });
        }
      });
    } else {
      return { top: 0, behavior: "smooth" };
    }
  },
});

router.afterEach((to) => {
  const baseTitle = "Адвокат Шкода Алексей Игоревич";
  document.title = to.meta.title ? `${to.meta.title}` : baseTitle;
});

export default router;
