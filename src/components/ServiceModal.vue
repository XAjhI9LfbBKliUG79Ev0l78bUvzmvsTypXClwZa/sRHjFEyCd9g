<template>
  <transition name="modal-fade">
    <div
      v-if="isVisible"
      class="modal-overlay"
      @click.self="closeModal"
      role="dialog"
      aria-modal="true"
      :aria-labelledby="modalTitleId"
      :aria-describedby="modalDescriptionId"
    >
      <div class="modal-container" ref="modalContainerRef" tabindex="-1">
        <header class="modal-header">
          <h2 class="modal-title" :id="modalTitleId">{{ title }}</h2>
          <button
            @click="closeModal"
            class="modal-close-btn"
            aria-label="Закрыть окно"
            ref="closeButtonRef"
          >
            <IconClose aria-hidden="true" />
          </button>
        </header>
        <section class="modal-body" :id="modalDescriptionId">
          <div
            v-for="(paragraph, index) in formattedDetailedDescription"
            :key="index"
            v-html="paragraph"
            class="modal-content-block"
          ></div>
        </section>
      </div>
    </div>
  </transition>
</template>

<script setup>
import {
  defineProps,
  defineEmits,
  computed,
  watch,
  onUnmounted,
  ref,
  nextTick,
} from "vue";
import IconClose from "@/components/icons/IconClose.vue";

const props = defineProps({
  isVisible: { type: Boolean, default: false },
  title: { type: String, required: true },
  formattedDetailedDescription: { type: Array, required: true },
});

const emit = defineEmits(["close"]);

const modalTitleId = computed(
  () =>
    `modal-title-${props.title
      .replace(/\s+/g, "-")
      .toLowerCase()
      .replace(/[^a-z0-9-]/gi, "")}`,
);
const modalDescriptionId = computed(
  () =>
    `modal-desc-${props.title
      .replace(/\s+/g, "-")
      .toLowerCase()
      .replace(/[^a-z0-9-]/gi, "")}`,
);

const modalContainerRef = ref(null);
const closeButtonRef = ref(null);
let previouslyFocusedElement = null;

const closeModal = () => {
  emit("close");
};

const handleEscKey = (event) => {
  if (event.key === "Escape" && props.isVisible) {
    closeModal();
  }
};

const trapFocus = (event) => {
  if (!props.isVisible || !modalContainerRef.value) return;

  const focusableElements = Array.from(
    modalContainerRef.value.querySelectorAll(
      'a[href]:not([disabled]), button:not([disabled]), textarea:not([disabled]), input[type="text"]:not([disabled]), input[type="radio"]:not([disabled]), input[type="checkbox"]:not([disabled]), select:not([disabled]), [tabindex]:not([tabindex="-1"])',
    ),
  ).filter((el) => el.offsetParent !== null);

  if (focusableElements.length === 0) return;

  const firstFocusable = focusableElements[0];
  const lastFocusable = focusableElements[focusableElements.length - 1];

  if (event.key === "Tab") {
    if (event.shiftKey) {
      if (document.activeElement === firstFocusable) {
        event.preventDefault();
        lastFocusable.focus();
      }
    } else {
      if (document.activeElement === lastFocusable) {
        event.preventDefault();
        firstFocusable.focus();
      }
    }
  }
};

watch(
  () => props.isVisible,
  async (newValue) => {
    if (newValue) {
      previouslyFocusedElement = document.activeElement;
      document.body.style.overflow = "hidden";
      document.addEventListener("keydown", handleEscKey);
      document.addEventListener("keydown", trapFocus);
      await nextTick();
      closeButtonRef.value?.focus();
    } else {
      document.body.style.overflow = "";
      document.removeEventListener("keydown", handleEscKey);
      document.removeEventListener("keydown", trapFocus);
      previouslyFocusedElement?.focus();
    }
  },
);

onUnmounted(() => {
  document.removeEventListener("keydown", handleEscKey);
  document.removeEventListener("keydown", trapFocus);
  if (document.body.style.overflow === "hidden") {
    document.body.style.overflow = "";
  }
});
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  inset: 0;
  background-color: rgba(17, 24, 39, 0.75);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  padding: var(--spacing-md);
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
}

.modal-container {
  background-color: var(--color-bg-white);
  border-radius: var(--border-radius-xl);
  box-shadow: var(--shadow-xl);
  width: 100%;
  max-width: 720px;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: var(--border-width) solid var(--color-border);
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base),
    transform 0.3s var(--transition-base);
}
.modal-container:focus {
  outline: none;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-md) var(--spacing-lg);
  border-bottom: var(--border-width) solid var(--color-border-light);
  flex-shrink: 0;
  transition: border-color var(--transition-base);
}

.modal-title {
  font-size: 1.375rem;
  font-weight: 700;
  color: var(--color-primary-dark);
  margin: 0;
  line-height: 1.35;
  transition: color var(--transition-base);
}

.modal-close-btn {
  background: none;
  border: none;
  color: var(--color-secondary);
  cursor: pointer;
  padding: var(--spacing-xs);
  line-height: 0;
  border-radius: var(--border-radius-full);
  transition:
    color var(--transition-fast),
    background-color var(--transition-fast),
    transform var(--transition-fast);
}
.modal-close-btn svg {
  width: 1.75rem;
  height: 1.75rem;
  display: block;
}
.modal-close-btn:hover {
  color: var(--color-text-base);
  background-color: var(--color-border-light);
  transform: scale(1.1) rotate(90deg);
}
.modal-close-btn:focus {
  outline: none;
}
.modal-close-btn:focus-visible {
  color: var(--color-text-base);
  background-color: var(--color-border-light);
  box-shadow:
    0 0 0 2px var(--color-bg-white),
    0 0 0 4px var(--color-focus);
  transform: scale(1.1) rotate(90deg);
}

.modal-body {
  padding: var(--spacing-lg);
  overflow-y: auto;
  flex-grow: 1;
  color: var(--color-text-base);
  line-height: var(--line-height-base);
  font-size: 1rem;
  transition: color var(--transition-base);
}

.modal-content-block {
  margin-block-end: var(--spacing-md);
}
.modal-content-block:last-child {
  margin-block-end: 0;
}

.modal-body :deep(ul) {
  list-style-position: outside;
  padding-inline-start: calc(var(--spacing-lg) + var(--spacing-xs));
  margin-block-start: var(--spacing-sm);
  margin-block-end: var(--spacing-md);
}
.modal-body :deep(li) {
  margin-block-end: var(--spacing-sm);
  line-height: 1.6;
}
.modal-body :deep(li::marker) {
  color: var(--color-primary);
}
.modal-body :deep(strong) {
  font-weight: 700;
  color: var(--color-primary-dark);
  transition: color var(--transition-base);
}
.modal-body :deep(p) {
  max-width: none;
  margin-block-end: var(--spacing-md);
}
.modal-body :deep(p:last-child) {
  margin-block-end: 0;
}
.modal-body :deep(em) {
  color: var(--color-text-muted);
  font-style: italic;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.25s var(--transition-base);
}
.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}
.modal-fade-enter-active .modal-container,
.modal-fade-leave-active .modal-container {
  transition:
    transform 0.3s var(--transition-base),
    opacity 0.25s var(--transition-base);
}
.modal-fade-enter-from .modal-container,
.modal-fade-leave-to .modal-container {
  transform: translateY(30px) scale(0.97);
  opacity: 0;
}

.dark-theme .modal-overlay {
  background-color: rgba(0, 0, 0, 0.85);
}
.dark-theme .modal-container {
  background-color: var(--color-bg-white-dark-theme);
  border-color: var(--color-border-dark-theme);
}
.dark-theme .modal-header {
  border-bottom-color: var(--color-border-dark-theme);
}
.dark-theme .modal-title {
  color: var(--color-primary-dark-theme);
}
.dark-theme .modal-close-btn {
  color: var(--color-secondary-dark-theme);
}
.dark-theme .modal-close-btn:hover {
  color: var(--color-text-base-dark-theme);
  background-color: var(--color-border-light-dark-theme);
}
.dark-theme .modal-close-btn:focus-visible {
  background-color: var(--color-border-light-dark-theme);
  box-shadow:
    0 0 0 2px var(--color-bg-white-dark-theme),
    0 0 0 4px var(--color-focus-dark-theme);
}
.dark-theme .modal-body {
  color: var(--color-text-base-dark-theme);
}
.dark-theme .modal-body :deep(strong) {
  color: var(--color-primary-dark-theme);
}
.dark-theme .modal-body :deep(em) {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .modal-body :deep(li::marker) {
  color: var(--color-primary-dark-theme);
}

@media (max-width: 600px) {
  .modal-overlay {
    padding: var(--spacing-sm) var(--spacing-xs);
    align-items: flex-end;
  }
  .modal-container {
    max-height: 90vh;
    border-radius: var(--border-radius-xl) var(--border-radius-xl) 0 0;
    margin-bottom: 0;
    border-bottom: none;
  }
  .modal-fade-enter-from .modal-container,
  .modal-fade-leave-to .modal-container {
    transform: translateY(100%);
    opacity: 1;
  }
  .modal-body {
    padding: var(--spacing-md) var(--spacing-sm);
  }
  .modal-title {
    font-size: 1.2rem;
  }
}
</style>
