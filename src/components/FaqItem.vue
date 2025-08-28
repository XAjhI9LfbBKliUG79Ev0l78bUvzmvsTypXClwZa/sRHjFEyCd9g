<template>
  <details class="faq-item" :id="faqId" @toggle="handleToggle">
    <summary
      :id="summaryId"
      class="faq-question"
      role="button"
      :aria-expanded="isOpen.toString()"
      :aria-controls="answerId"
      @click.prevent="toggleOpen"
    >
      <span class="question-text">{{ question }}</span>
      <span class="faq-icon" aria-hidden="true"></span>
    </summary>
    <div
      class="faq-answer"
      :id="answerId"
      role="region"
      :aria-labelledby="summaryId"
      v-show="isOpen"
      ref="answerRef"
    >
      <p>{{ answer }}</p>
    </div>
  </details>
</template>

<script setup>
import { defineProps, ref, computed } from "vue";
const props = defineProps({
  question: { type: String, required: true },
  answer: { type: String, required: true },
});

const isOpen = ref(false);
const answerRef = ref(null);
const faqIdBase = computed(() =>
  props.question
    .toLowerCase()
    .replace(/\s+/g, "-")
    .replace(/[^a-z0-9-]/gi, ""),
);
const faqId = computed(() => `faq-q-${faqIdBase.value}`);
const summaryId = computed(() => `faq-s-${faqIdBase.value}`);
const answerId = computed(() => `faq-a-${faqIdBase.value}`);

const toggleOpen = (event) => {
  const detailsElement = event.currentTarget.parentElement;
  isOpen.value = !detailsElement.open;
  detailsElement.open = isOpen.value;
};

const handleToggle = (event) => {
  isOpen.value = event.target.open;
};
</script>

<style scoped>
.faq-item {
  background-color: var(--color-bg-white);
  border: var(--border-width) solid var(--color-border-light);
  border-radius: var(--border-radius-lg);
  overflow: hidden;
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base);
}
.faq-item + .faq-item {
  margin-top: var(--spacing-sm);
}

.faq-question {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: var(--spacing-md);
  padding: var(--spacing-md) var(--spacing-lg);
  font-size: 1.05rem;
  font-weight: 600;
  cursor: pointer;
  list-style: none;
  color: var(--color-primary-dark);
  width: 100%;
  text-align: left;
  background-color: transparent;
  border: none;
  transition:
    color var(--transition-base),
    background-color var(--transition-base);
  position: relative;
}
.faq-question::-webkit-details-marker {
  display: none;
}
.faq-question:focus {
  outline: none;
}
.faq-question:focus-visible {
  color: var(--color-primary);
  background-color: var(--color-primary-lighter);
}
.faq-question:focus-visible::before {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: inherit;
  border: 2px solid var(--color-focus);
  pointer-events: none;
}
.faq-item:first-child > .faq-question {
  border-top-left-radius: var(--border-radius-lg);
  border-top-right-radius: var(--border-radius-lg);
}
.faq-item:last-child > .faq-question {
  border-bottom-left-radius: var(--border-radius-lg);
  border-bottom-right-radius: var(--border-radius-lg);
}
.faq-item[open]:last-child > .faq-question {
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
}

.question-text {
  flex-grow: 1;
  padding-right: var(--spacing-sm);
}

.faq-icon {
  inline-size: 1.375rem;
  block-size: 1.375rem;
  border: 2px solid currentColor;
  border-radius: 50%;
  position: relative;
  transition:
    transform 0.3s ease-in-out,
    border-color var(--transition-base);
  flex-shrink: 0;
}
.faq-icon::before,
.faq-icon::after {
  content: "";
  position: absolute;
  background-color: currentColor;
  transition:
    transform 0.3s ease-in-out,
    background-color var(--transition-base);
  top: 50%;
  left: 50%;
}
.faq-icon::before {
  width: 60%;
  height: 2px;
  transform: translate(-50%, -50%) rotate(0deg);
}
.faq-icon::after {
  width: 2px;
  height: 60%;
  transform: translate(-50%, -50%) rotate(0deg);
}

.faq-item[open] > summary .faq-icon::before,
.faq-question[aria-expanded="true"] .faq-icon::before {
  transform: translate(-50%, -50%) rotate(90deg);
}
.faq-item[open] > summary .faq-icon::after,
.faq-question[aria-expanded="true"] .faq-icon::after {
  transform: translate(-50%, -50%) rotate(180deg);
  opacity: 0;
}

.faq-answer {
  padding: var(--spacing-sm) var(--spacing-lg) var(--spacing-lg);
  color: var(--color-text-muted);
  font-size: 0.9375rem;
  transition:
    color var(--transition-base),
    opacity 0.3s ease-in-out,
    max-height 0.3s ease-in-out;
  line-height: 1.65;
  border-top: 1px solid var(--color-border-light);
}
.faq-answer p {
  max-width: none;
  margin: 0;
}

.dark-theme .faq-item {
  background-color: var(--color-bg-white-dark-theme);
  border-color: var(--color-border-light-dark-theme);
}
.dark-theme .faq-question {
  color: var(--color-primary-dark-theme);
}
.dark-theme .faq-question:focus-visible {
  background-color: var(--color-primary-lighter-dark-theme);
  color: var(--color-primary-dark-dark-theme);
}
.dark-theme .faq-question:focus-visible::before {
  border-color: var(--color-focus-dark-theme);
}
.dark-theme .faq-answer {
  color: var(--color-text-muted-dark-theme);
  border-top-color: var(--color-border-dark-theme);
}
.dark-theme .faq-icon {
  border-color: var(--color-primary-dark-theme);
}
.dark-theme .faq-icon::before,
.dark-theme .faq-icon::after {
  background-color: var(--color-primary-dark-theme);
}

@media (min-width: 768px) {
  .faq-question {
    font-size: 1.1rem;
  }
}
</style>
