<template>
  <div>
    <input
      type="checkbox"
      id="theme-toggle"
      class="theme-toggle-checkbox"
      aria-label="Переключить темную/светлую тему"
      :checked="isDark"
      @change="toggleTheme"
      ref="themeToggleCheckbox"
    />
    <label
      for="theme-toggle"
      class="theme-toggle-label"
      title="Переключить тему"
      tabindex="0"
      @keydown.enter.prevent="handleLabelKeydown"
      @keydown.space.prevent="handleLabelKeydown"
    >
      <IconSun class="sun-icon" aria-hidden="true" focusable="false" />
      <IconMoon class="moon-icon" aria-hidden="true" focusable="false" />
      <span class="toggle-slider"></span>
    </label>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import IconSun from "@/components/icons/IconSun.vue";
import IconMoon from "@/components/icons/IconMoon.vue";

const isDark = ref(false);
const themeToggleCheckbox = ref(null);

const applyTheme = (dark) => {
  const scrollX = window.scrollX;
  const scrollY = window.scrollY;

  if ('scrollRestoration' in history) {
    history.scrollRestoration = 'manual';
  }

  if (dark) {
    document.documentElement.classList.add("dark-theme");
    localStorage.setItem("theme", "dark");
  } else {
    document.documentElement.classList.remove("dark-theme");
    localStorage.setItem("theme", "light");
  }
  isDark.value = dark;

  window.scrollTo(scrollX, scrollY);

  if ('scrollRestoration' in history) {
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        history.scrollRestoration = 'auto';
      });
    });
  }
};

const initializeTheme = () => {
  const savedTheme = localStorage.getItem("theme");

  if (savedTheme) {
    applyTheme(savedTheme === "dark");
  } else {
    applyTheme(true);
  }

  let prefersDarkQuery = window.matchMedia
    ? window.matchMedia("(prefers-color-scheme: dark)")
    : null;

  if (prefersDarkQuery) {
    prefersDarkQuery.addEventListener("change", (e) => {
      if (localStorage.getItem("theme") === null) {
        applyTheme(e.matches);
      }
    });
  }
};

const toggleTheme = () => {
  applyTheme(!isDark.value);
};

const handleLabelKeydown = (event) => {
  if (event.key === "Enter" || event.key === " ") {
    if (themeToggleCheckbox.value) {
      themeToggleCheckbox.value.checked = !themeToggleCheckbox.value.checked;
      toggleTheme();
    }
  }
};

onMounted(() => {
  initializeTheme();
});
</script>

<style scoped>
.theme-toggle-checkbox {
  border: 0;
  clip: rect(0 0 0 0);
  height: 1px;
  margin: -1px;
  overflow: hidden;
  padding: 0;
  position: absolute;
  width: 1px;
  white-space: nowrap;
}

.theme-toggle-label {
  position: fixed;
  bottom: var(--spacing-md);
  right: var(--spacing-md);
  z-index: 101;
  width: 50px;
  height: 26px;
  background-color: var(--color-secondary);
  border-radius: var(--border-radius-full);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 4px;
  transition:
    background-color var(--transition-fast),
    border-color var(--transition-base),
    box-shadow var(--transition-fast);
  border: 1px solid var(--color-border);
  -webkit-tap-highlight-color: transparent;
}
.theme-toggle-label:hover {
  background-color: var(--color-text-muted);
}
.theme-toggle-checkbox:focus-visible + .theme-toggle-label,
.theme-toggle-label:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 3px;
  box-shadow: 0 0 0 3px var(--color-bg-light);
}

.theme-toggle-label .sun-icon,
.theme-toggle-label .moon-icon {
  width: 18px;
  height: 18px;
  transition:
    opacity var(--transition-fast),
    transform var(--transition-fast);
  position: relative;
  z-index: 1;
}
.theme-toggle-label .sun-icon {
  color: #facc15;
  opacity: 1;
  transform: scale(1) rotate(0deg);
}
.theme-toggle-label .moon-icon {
  color: #e5e7eb;
  opacity: 0;
  transform: scale(0.5) rotate(-90deg);
}

.toggle-slider {
  position: absolute;
  top: 2px;
  left: 3px;
  width: 20px;
  height: 20px;
  background-color: var(--color-bg-white);
  border-radius: 50%;
  transition:
    transform var(--transition-base) ease-in-out,
    background-color var(--transition-base);
}

.dark-theme .theme-toggle-label {
  background-color: var(--color-primary-dark-theme);
  border-color: var(--color-border-dark-theme);
}
.dark-theme .theme-toggle-label:hover {
  background-color: var(--color-primary-dark-dark-theme);
}
.dark-theme .theme-toggle-checkbox:focus-visible + .theme-toggle-label,
.dark-theme .theme-toggle-label:focus-visible {
  outline-color: var(--color-focus-dark-theme);
  box-shadow: 0 0 0 3px var(--color-bg-white-dark-theme);
}

.dark-theme .toggle-slider {
  transform: translateX(23px);
  background-color: var(--color-bg-white-dark-theme);
}

.dark-theme .theme-toggle-label .sun-icon {
  opacity: 0;
  transform: scale(0.5) rotate(90deg);
}
.dark-theme .theme-toggle-label .moon-icon {
  opacity: 1;
  transform: scale(1) rotate(0deg);
}

@media (max-width: 480px) {
  .theme-toggle-label {
    bottom: var(--spacing-sm);
    right: var(--spacing-sm);
  }
}
</style>
