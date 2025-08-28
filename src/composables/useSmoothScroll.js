import { nextTick } from "vue";

export function useSmoothScroll() {
  const getHeaderHeight = () => {
    const header = document.querySelector(".header");
    return header ? header.offsetHeight : 60;
  };

  const scrollToTarget = async (target, event, isRouterNav = false, router) => {
    if (event) {
      event.preventDefault();
    }

    let element;
    let hash = "";

    if (typeof target === "string") {
      if (target.startsWith("#")) {
        hash = target;
        await nextTick();
        element = document.querySelector(hash);
      } else {
        if (router && target.includes("#")) {
          const [path, h] = target.split("#");
          hash = "#" + h;
          if (router.currentRoute.value.path !== path) {
            await router.push(target);
            return;
          }
          await nextTick();
          element = document.querySelector(hash);
        } else if (router) {
          await router.push(target);
          return;
        }
      }
    } else if (target instanceof HTMLElement) {
      element = target;
    }

    if (element) {
      const headerOffset = getHeaderHeight();
      const elementPosition = element.getBoundingClientRect().top;
      const offsetPosition =
        elementPosition + window.pageYOffset - headerOffset;

      window.scrollTo({
        top: offsetPosition,
        behavior: "smooth",
      });

      if (hash && !isRouterNav) {
        history.pushState(null, "", hash);
      }
    } else if (hash === "#top" || target === "/") {
      window.scrollTo({ top: 0, behavior: "smooth" });
      if (target === "/" && !isRouterNav) {
        history.pushState(null, "", "/");
      } else if (hash === "#top" && !isRouterNav) {
        history.pushState(null, "", " ");
      }
    } else {
      console.warn(`[useSmoothScroll] Element not found for target:`, target);
    }
  };

  return { scrollToTarget, getHeaderHeight };
}
