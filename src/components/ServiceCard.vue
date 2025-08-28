<template>
  <article
    class="service-card"
    :aria-labelledby="ariaId"
    tabindex="0"
    role="button"
    @click="$emit('card-click')"
    @keydown.enter.prevent="$emit('card-click')"
    @keydown.space.prevent="$emit('card-click')"
  >
    <div class="card-icon" aria-hidden="true">
      <component :is="iconComponent" />
    </div>
    <h3 class="card-title" :id="ariaId">{{ title }}</h3>
    <p class="card-description">{{ description }}</p>
    <span class="learn-more-link" aria-hidden="true"
      >Узнать больше <span class="arrow" aria-hidden="true">→</span></span
    >
  </article>
</template>

<script setup>
import { defineProps, defineEmits } from "vue";

defineProps({
  title: { type: String, required: true },
  description: { type: String, required: true },
  iconComponent: { type: Object, required: true },
  ariaId: { type: String, required: true },
});

defineEmits(["card-click"]);
</script>

<style scoped>
.service-card {
  background-color: var(--color-bg-white);
  padding: var(--spacing-lg);
  border-radius: var(--border-radius-lg);
  box-shadow: var(--shadow-md);
  transition:
    transform var(--transition-base),
    box-shadow var(--transition-base),
    background-color var(--transition-base),
    border-color var(--transition-base);
  border: var(--border-width) solid var(--color-border-light);
  display: flex;
  flex-direction: column;
  text-align: left;
  cursor: pointer;
  position: relative;
}
.service-card:hover,
.service-card:focus-within {
  transform: translateY(-6px);
  box-shadow: var(--shadow-xl);
  border-color: var(--color-primary);
}
.service-card:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 2px;
  border-color: var(--color-focus);
}

.card-icon {
  color: var(--color-primary-dark);
  margin-block-end: var(--spacing-md);
  transition: color var(--transition-base);
}
.card-icon svg {
  inline-size: 2.75rem;
  block-size: 2.75rem;
}
.card-title {
  font-size: 1.2rem;
  margin-block-start: 0;
  margin-block-end: var(--spacing-sm);
  color: var(--color-primary-dark);
  transition: color var(--transition-base);
}
.card-description {
  font-size: 0.9375rem;
  color: var(--color-text-muted);
  flex-grow: 1;
  margin-block-end: var(--spacing-md);
  transition: color var(--transition-base);
  max-width: none;
  line-height: 1.6;
}

.learn-more-link {
  font-size: 0.9375rem;
  font-weight: 600;
  color: var(--color-primary);
  text-align: left;
  margin-top: auto;
  transition:
    color var(--transition-base),
    transform var(--transition-fast);
  display: inline-flex;
  align-items: center;
}
.learn-more-link .arrow {
  margin-left: var(--spacing-xs);
  transition: transform var(--transition-fast) ease-out;
}
.service-card:hover .learn-more-link,
.service-card:focus-within .learn-more-link {
  color: var(--color-primary-dark);
}
.service-card:hover .learn-more-link .arrow,
.service-card:focus-within .learn-more-link .arrow {
  transform: translateX(4px);
}

.dark-theme .service-card {
  background-color: var(--color-bg-white-dark-theme);
  box-shadow: var(--shadow-md-dark);
  border-color: var(--color-border-light-dark-theme);
}
.dark-theme .service-card:hover,
.dark-theme .service-card:focus-within {
  box-shadow: var(--shadow-xl-dark);
  border-color: var(--color-primary-dark-theme);
}
.dark-theme .service-card:focus-visible {
  outline-color: var(--color-focus-dark-theme);
  border-color: var(--color-focus-dark-theme);
}
.dark-theme .card-icon {
  color: var(--color-primary-dark-theme);
}
.dark-theme .card-title {
  color: var(--color-primary-dark-theme);
}
.dark-theme .card-description {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .learn-more-link {
  color: var(--color-primary-dark-theme);
}
.dark-theme .service-card:hover .learn-more-link,
.dark-theme .service-card:focus-within .learn-more-link {
  color: var(--color-primary-dark-dark-theme);
}

@media (max-width: 767px) {
  .service-card {
    padding: var(--spacing-md);
  }
  .card-icon svg {
    inline-size: 2.25rem;
    block-size: 2.25rem;
  }
  .card-title {
    font-size: 1.1rem;
  }
}
</style>
``` **Part 3 of 3**```
