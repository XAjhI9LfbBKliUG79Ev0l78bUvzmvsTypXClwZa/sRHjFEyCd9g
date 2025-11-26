// src/composables/useModal.js
import { ref } from "vue";

export function useModal() {
  const isVisible = ref(false);
  const title = ref("");
  const description = ref([]);

  const openModal = (modalTitle, modalDescription) => {
    title.value = modalTitle;
    description.value = modalDescription;
    isVisible.value = true;
  };

  const closeModal = () => {
    isVisible.value = false;
  };

  return { isVisible, title, description, openModal, closeModal };
}
