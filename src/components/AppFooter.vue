<template>
  <footer class="footer">
    <div class="container footer-container">
      <p>
        © <span>{{ currentYear }}</span> Шкода Алексей Игоревич. Информация на
        сайте не является публичной офертой и носит информационный характер.
      </p>
      <a href="#top" class="back-to-top" @click.prevent="scrollToTop"
        >Наверх ↑</a
      >
    </div>
  </footer>
</template>

<script setup>
import { ref } from "vue";

const currentYear = ref(new Date().getFullYear());

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
};
</script>

<style scoped>
.footer {
  background-color: var(--color-primary-dark);
  color: var(--color-text-inverse);
  padding-block: var(--spacing-lg);
  font-size: var(--font-size-sm);
  text-align: center;
  transition:
    background-color var(--transition-base),
    color var(--transition-base);
}
.footer-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-md);
}
.footer p {
  margin: 0;
  opacity: 0.85;
  max-width: 80ch;
  line-height: 1.5;
  transition: opacity var(--transition-base);
}
.back-to-top {
  color: inherit;
  opacity: 0.85;
  font-weight: 600;
  text-decoration: none;
  transition:
    opacity var(--transition-base),
    color var(--transition-base),
    background-color var(--transition-base);
  padding: var(--spacing-xs) var(--spacing-sm);
  border-radius: var(--border-radius-sm);
  border: 1px solid transparent;
}
.back-to-top:hover,
.back-to-top:focus-visible {
  opacity: 1;
  color: var(--color-bg-white);
  text-decoration: underline;
  background-color: rgba(255, 255, 255, 0.1);
}
.back-to-top:focus-visible {
  outline: 2px solid var(--color-primary-light);
  outline-offset: 2px;
  text-decoration: none;
}

.dark-theme .footer {
  background-color: var(--color-primary-dark-dark-theme);
  color: var(--color-text-base-dark-theme);
}
.dark-theme .footer p {
  opacity: 0.9;
}
.dark-theme .footer .back-to-top {
  color: var(--color-text-base-dark-theme);
  opacity: 0.9;
}
.dark-theme .footer .back-to-top:hover,
.dark-theme .footer .back-to-top:focus-visible {
  color: var(--color-bg-white);
  background-color: rgba(0, 0, 0, 0.2);
  opacity: 1;
}
.dark-theme .back-to-top:focus-visible {
  outline-color: var(--color-primary-dark-theme);
}

@media (min-width: 768px) {
  .footer-container {
    flex-direction: row;
    justify-content: space-between;
  }
  .footer p {
    text-align: left;
  }
}
</style>
