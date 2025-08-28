<template>
  <header class="header" ref="appHeader">
    <div class="container header-container">
      <RouterLink
        to="/"
        class="logo-area"
        aria-label="Шкода Алексей Игоревич - На главную"
        @click="handleLogoClick"
      >
        <img
          src="@/assets/logo.svg"
          alt=""
          class="logo-image"
          width="40"
          height="40"
        />
        <div class="logo-text">
          <span class="site-title">Адвокат</span>
          <span class="lawyer-name">Шкода Алексей Игоревич</span>
        </div>
      </RouterLink>
      <button
        class="mobile-nav-toggle"
        @click="toggleMobileMenu"
        :aria-expanded="isMobileMenuOpen.toString()"
        aria-controls="main-navigation"
        ref="mobileNavToggleRef"
      >
        <span class="sr-only">{{
          isMobileMenuOpen ? "Закрыть меню" : "Открыть меню"
        }}</span>
        <IconMenu v-if="!isMobileMenuOpen" aria-hidden="true" />
        <IconClose v-else aria-hidden="true" />
      </button>
      <nav
        class="main-nav"
        :class="{ 'is-open': isMobileMenuOpen }"
        id="main-navigation"
        aria-label="Основная навигация"
        ref="mainNavRef"
      >
        <ul>
          <li>
            <a
              href="/#services"
              class="nav-link"
              @click="smoothScrollAndCloseMenu('#services', $event)"
              >Услуги</a
            >
          </li>
          <li>
            <a
              href="/#contact"
              class="nav-link"
              @click="smoothScrollAndCloseMenu('#contact', $event)"
              >Контакты</a
            >
          </li>
          <li>
            <a
              href="/#faq"
              class="nav-link"
              @click="smoothScrollAndCloseMenu('#faq', $event)"
              >Вопросы</a
            >
          </li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch, nextTick } from "vue";
import { RouterLink, useRouter, useRoute } from "vue-router";
import IconMenu from "@/components/icons/IconMenu.vue";
import IconClose from "@/components/icons/IconClose.vue";
import { useSmoothScroll } from "@/composables/useSmoothScroll.js";

const router = useRouter();
const route = useRoute();
const { scrollToTarget } = useSmoothScroll();

const appHeader = ref(null);
const mainNavRef = ref(null);
const mobileNavToggleRef = ref(null);
const isMobileMenuOpen = ref(false);
let firstFocusableElement = null;
let lastFocusableElement = null;

const smoothScrollAndCloseMenu = (hash, event) => {
  if (route.path === "/" && hash.startsWith("#")) {
    if (isMobileMenuOpen.value) {
      isMobileMenuOpen.value = false;
    }
    scrollToTarget(hash, event);
  } else {
    if (hash.startsWith("#")) {
      router.push("/" + hash);
    } else {
      router.push(hash);
    }
    if (isMobileMenuOpen.value) {
      isMobileMenuOpen.value = false;
    }
  }
};

const handleLogoClick = (event) => {
  if (route.path === "/") {
    scrollToTarget("#top", event);
  } else {
    router.push("/");
  }
  if (isMobileMenuOpen.value) {
    isMobileMenuOpen.value = false;
  }
};

const setFocusableElements = () => {
  if (mainNavRef.value) {
    const focusable = Array.from(
      mainNavRef.value.querySelectorAll("a[href], button:not([disabled])"),
    );
    firstFocusableElement = focusable[0];
    lastFocusableElement = focusable[focusable.length - 1];
  }
};

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
};

watch(isMobileMenuOpen, async (isOpen) => {
  if (isOpen) {
    await nextTick();
    setFocusableElements();
    firstFocusableElement?.focus();
    document.body.style.overflow = "hidden";
  } else {
    document.body.style.overflow = "";
    mobileNavToggleRef.value?.focus();
  }
});

const handleTrapFocus = (event) => {
  if (isMobileMenuOpen.value && mainNavRef.value) {
    if (event.key === "Tab") {
      if (event.shiftKey) {
        if (document.activeElement === firstFocusableElement) {
          event.preventDefault();
          lastFocusableElement?.focus();
        }
      } else {
        if (document.activeElement === lastFocusableElement) {
          event.preventDefault();
          firstFocusableElement?.focus();
        }
      }
    }
  }
};

const handleClickOutside = (event) => {
  if (
    isMobileMenuOpen.value &&
    appHeader.value &&
    !appHeader.value.contains(event.target)
  ) {
    isMobileMenuOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener("click", handleClickOutside);
  document.addEventListener("keydown", handleTrapFocus);
});

onUnmounted(() => {
  document.removeEventListener("click", handleClickOutside);
  document.removeEventListener("keydown", handleTrapFocus);
  document.body.style.overflow = "";
});
</script>

<style scoped>
.header {
  background-color: var(--color-bg-white);
  box-shadow: var(--shadow-sm);
  position: sticky;
  inset-block-start: 0;
  z-index: 100;
  transition:
    background-color var(--transition-base),
    box-shadow var(--transition-base);
}
.header-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  padding-block: var(--spacing-sm);
  min-block-size: 60px;
}
.logo-area {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
  color: inherit;
  text-decoration: none;
  flex-shrink: 0;
}
.logo-area:hover,
.logo-area:focus {
  opacity: 1;
}
.logo-area:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 3px;
  border-radius: var(--border-radius-sm);
}
.logo-image {
  block-size: 40px;
  inline-size: 40px;
  object-fit: contain;
  background-color: var(--color-border-light);
  border-radius: var(--border-radius);
  transition: background-color var(--transition-base);
}
.logo-text {
  line-height: 1.25;
}
.site-title {
  display: block;
  font-size: 0.8rem;
  color: var(--color-text-muted);
  font-weight: 400;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  transition: color var(--transition-base);
}
.lawyer-name {
  display: block;
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--color-primary-dark);
  transition: color var(--transition-base);
}

.mobile-nav-toggle {
  display: none;
  background: none;
  border: none;
  color: var(--color-primary-dark);
  padding: var(--spacing-xs);
  cursor: pointer;
  position: relative;
  z-index: 9999;
  border-radius: var(--border-radius-sm);
}
.mobile-nav-toggle svg {
  width: 28px;
  height: 28px;
}
.mobile-nav-toggle:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 2px;
}

.main-nav ul {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-sm);
  padding: 0;
  margin: 0;
  list-style: none;
  align-items: center;
}
.nav-link {
  font-weight: 600;
  font-size: 0.875rem;
  color: var(--color-secondary);
  position: relative;
  padding-block: var(--spacing-xs);
  padding-inline: var(--spacing-xs);
  white-space: nowrap;
  text-decoration: none;
  transition:
    color var(--transition-base),
    opacity var(--transition-base);
  border-radius: var(--border-radius-sm);
}
.nav-link::after {
  content: "";
  position: absolute;
  width: 0;
  height: 2px;
  inset-block-end: -3px;
  inset-inline-start: 50%;
  transform: translateX(-50%);
  background-color: var(--color-primary);
  transition:
    width var(--transition-base),
    background-color var(--transition-base);
}
.nav-link:hover,
.nav-link:focus {
  color: var(--color-primary);
  opacity: 1;
  outline: none;
}
.nav-link:focus-visible {
  color: var(--color-primary);
  outline: 2px solid var(--color-focus);
  outline-offset: 3px;
  text-decoration: none;
}
.nav-link:focus-visible::after {
  width: 100%;
}
.nav-link:hover::after {
  width: 100%;
}

.dark-theme .header {
  background-color: var(--color-bg-white-dark-theme);
  box-shadow: var(--shadow-sm-dark);
}
.dark-theme .logo-area:focus-visible {
  outline-color: var(--color-focus-dark-theme);
}
.dark-theme .header .logo-image {
  background-color: var(--color-border-dark-theme);
}
.dark-theme .header .site-title {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .header .lawyer-name {
  color: var(--color-primary-dark-theme);
}
.dark-theme .mobile-nav-toggle {
  color: var(--color-primary-dark-theme);
}
.dark-theme .mobile-nav-toggle:focus-visible {
  outline-color: var(--color-focus-dark-theme);
}
.dark-theme .header .nav-link {
  color: var(--color-secondary-dark-theme);
}
.dark-theme .header .nav-link::after {
  background-color: var(--color-primary-dark-theme);
}
.dark-theme .header .nav-link:hover,
.dark-theme .header .nav-link:focus,
.dark-theme .header .nav-link:focus-visible {
  color: var(--color-primary-dark-theme);
}
.dark-theme .nav-link:focus-visible {
  outline-color: var(--color-focus-dark-theme);
}

@media (max-width: 767px) {
  .mobile-nav-toggle {
    display: block;
  }
  .main-nav {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background-color: var(--color-bg-white);
    box-shadow: var(--shadow-lg);
    padding: var(--spacing-md);
    border-top: var(--border-width) solid var(--color-border-light);
    z-index: 99;
    max-height: calc(100vh - 60px);
    overflow-y: auto;
  }
  .main-nav.is-open {
    display: block;
  }
  .main-nav ul {
    flex-direction: column;
    align-items: stretch;
    gap: var(--spacing-unit);
  }
  .nav-link {
    display: block;
    padding: var(--spacing-sm) var(--spacing-md);
    font-size: 1rem;
    text-align: left;
  }
  .nav-link::after {
    inset-block-end: 5px;
    inset-inline-start: var(--spacing-md);
    transform: translateX(0);
    width: 0;
  }
  .nav-link:hover::after,
  .nav-link:focus-visible::after {
    width: calc(100% - (2 * var(--spacing-md)));
  }

  .dark-theme .main-nav {
    background-color: var(--color-bg-white-dark-theme);
    border-top-color: var(--color-border-dark-theme);
  }
}

@media (min-width: 768px) {
  .header-container {
    gap: var(--spacing-lg);
  }
  .logo-area {
    margin-inline-end: 0;
  }
  .site-title {
    font-size: 0.875rem;
  }
  .lawyer-name {
    font-size: 1.25rem;
  }

  .main-nav {
    display: block !important;
    position: static;
    background-color: transparent;
    box-shadow: none;
    padding: 0;
    border-top: none;
    width: auto;
    margin-left: auto;
    max-height: none;
    overflow-y: visible;
  }
  .main-nav ul {
    flex-direction: row;
    align-items: center;
    gap: var(--spacing-lg);
    justify-content: flex-end;
  }
  .nav-link {
    display: inline-block;
    padding-block: var(--spacing-unit);
    padding-inline: 0;
    font-size: 0.9375rem;
    text-align: left;
  }
  .nav-link::after {
    inset-block-end: -3px;
    inset-inline-start: 50%;
    transform: translateX(-50%);
  }
  .nav-link:hover::after,
  .nav-link:focus-visible::after {
    width: 100%;
  }
}

.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
</style>
