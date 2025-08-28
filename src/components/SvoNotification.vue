<template>
  <div
    v-if="isVisible"
    class="svo-notification"
    role="alert"
    aria-live="polite"
  >
    <div class="notification-content">
      <IconGavel class="notification-icon" aria-hidden="true" />
      <p>
        <strong>Помощь участникам СВО и их семьям.</strong>
        <button @click="handleLearnMoreClick" class="notification-link">
          Узнать больше
        </button>
      </p>
    </div>
    <button @click="dismiss" class="close-btn" aria-label="Закрыть уведомление">
      <IconClose aria-hidden="true" />
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

import IconGavel from "@/components/icons/IconGavel.vue";
import IconClose from "@/components/icons/IconClose.vue";


const isVisible = ref(false);

const notificationKey = "svoNotificationDismissed_v2";


const emit = defineEmits(['open-svo-modal']);

const dismiss = () => {
  isVisible.value = false;
  try {
    localStorage.setItem(notificationKey, "true");
  } catch (e) {
    console.warn("Failed to use localStorage for SVO notification:", e);
    try {
      sessionStorage.setItem(notificationKey, "true");
    } catch (e2) {
      console.warn("Failed to use sessionStorage for SVO notification:", e2);
    }
  }
};

const handleLearnMoreClick = () => {
  emit('open-svo-modal');
};

onMounted(() => {
  let dismissed = false;
  try {
    dismissed = localStorage.getItem(notificationKey) === "true";
  } catch (e) {
    console.warn("Failed to read localStorage for SVO notification:", e);
    try {
      dismissed = sessionStorage.getItem(notificationKey) === "true";
    } catch (e2) {
      console.warn("Failed to read sessionStorage for SVO notification:", e2);
    }
  }

  if (!dismissed) {
    isVisible.value = true;
  }
});
</script>

<style scoped>
.svo-notification {
  background-color: var(--color-primary-lighter);
  color: var(--color-text-base);
  padding: var(--spacing-sm) var(--spacing-md);
  border-bottom: var(--border-width) solid var(--color-primary-light);
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: var(--spacing-md);
  transition:
    background-color var(--transition-base),
    color var(--transition-base),
    border-color var(--transition-base),
    opacity 0.3s ease,
    transform 0.3s ease;
}

.notification-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--spacing-sm);
  flex-grow: 1;
}

.notification-icon {
  flex-shrink: 0;
  color: var(--color-primary-dark);
  inline-size: 1.75rem;
  block-size: 1.75rem;
  margin-top: 0.1em;
  transition: color var(--transition-base);
}

.svo-notification p {
  margin: 0;
  font-size: var(--font-size-sm);
  line-height: 1.5;
  flex-grow: 1;
  text-align: center;
}

.svo-notification strong {
  color: var(--color-primary-dark);
  font-weight: 600;
  transition: color var(--transition-base);
}

.notification-link {
  color: var(--color-primary-dark);
  font-weight: 600;
  text-decoration: underline;
  text-underline-offset: 3px;
  margin-inline-start: var(--spacing-xs);
  transition: color var(--transition-base);
  border-radius: var(--border-radius-sm);
}
.notification-link:hover,
.notification-link:focus {
  color: var(--color-primary);
  opacity: 1;
  outline: none;
}
.notification-link:focus-visible {
  color: var(--color-primary);
  outline: 2px solid var(--color-focus);
  outline-offset: 2px;
  text-decoration: none;
}

.close-btn {
  background: none;
  border: none;
  color: var(--color-secondary);
  font-size: 1.25rem;
  font-weight: normal;
  line-height: 1;
  cursor: pointer;
  padding: var(--spacing-xs);
  margin: -4px -6px -4px 0;
  align-self: center;
  transition:
    color var(--transition-fast),
    background-color var(--transition-fast),
    transform var(--transition-fast);
  border-radius: var(--border-radius-full);
}
.close-btn svg {
  display: block;
  width: 1.1em;
  height: 1.1em;
}
.close-btn:hover {
  color: var(--color-text-base);
  background-color: var(--color-border);
  transform: scale(1.05);
}
.close-btn:focus {
  outline: none;
}
.close-btn:focus-visible {
  color: var(--color-text-base);
  background-color: var(--color-border);
  box-shadow:
    0 0 0 2px var(--color-bg-light),
    0 0 0 4px var(--color-focus);
  transform: scale(1.05);
}

.dark-theme .svo-notification {
  background-color: var(--color-primary-lighter-dark-theme);
  color: var(--color-text-base-dark-theme);
  border-bottom-color: var(--color-primary-light-dark-theme);
}
.dark-theme .notification-icon {
  color: var(--color-primary-dark-theme);
}
.dark-theme .svo-notification strong {
  color: var(--color-primary-dark-theme);
}
.dark-theme .notification-link {
  color: var(--color-primary-dark-theme);
}
.dark-theme .notification-link:hover,
.dark-theme .notification-link:focus {
  color: var(--color-primary-dark-dark-theme);
}
.dark-theme .notification-link:focus-visible {
  outline-color: var(--color-focus-dark-theme);
}
.dark-theme .close-btn {
  color: var(--color-secondary-dark-theme);
}
.dark-theme .close-btn:hover {
  color: var(--color-text-base-dark-theme);
  background-color: var(--color-border-dark-theme);
}
.dark-theme .close-btn:focus-visible {
  color: var(--color-text-base-dark-theme);
  background-color: var(--color-border-dark-theme);
  box-shadow:
    0 0 0 2px var(--color-bg-light-dark-theme),
    0 0 0 4px var(--color-focus-dark-theme);
}

@media (max-width: 767px) {
  .svo-notification {
    padding: var(--spacing-sm);
  }
  .close-btn {
    align-self: flex-start;
    margin-top: -2px;
  }
}
@media (max-width: 480px) {
  .notification-content {
  }
  .svo-notification p {
    font-size: var(--font-size-xs);
  }
}
</style>
