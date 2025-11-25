<template>
  <AppHeader />
  <SvoNotification @open-svo-modal="handleOpenSvoModal" />
  <RouterView v-slot="{ Component, route }">
    <transition name="fade" mode="out-in">
      <component :is="Component" :key="route.path" />
    </transition>
  </RouterView>
  <AppFooter />
  <ThemeToggle />
  <ServiceModal
    :is-visible="isSvoModalVisible"
    :title="svoModalTitle"
    :formatted-detailed-description="svoModalDescription"
    @close="closeSvoModal"
  />
</template>

<script setup>
import { RouterView } from "vue-router";
import AppHeader from "@/components/AppHeader.vue";
import AppFooter from "@/components/AppFooter.vue";
import ThemeToggle from "@/components/ThemeToggle.vue";
import SvoNotification from "@/components/SvoNotification.vue";
import ServiceModal from "@/components/ServiceModal.vue";
import { useModal } from "@/composables/useModal.js";
import { modalConfig } from "@/config/index.js";

const {
  isVisible: isSvoModalVisible,
  title: svoModalTitle,
  description: svoModalDescription,
  openModal: openSvoModal,
  closeModal: closeSvoModal,
} = useModal();

const handleOpenSvoModal = () => {
  openSvoModal(modalConfig.svo.title, modalConfig.svo.description);
};
</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease-in-out;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
