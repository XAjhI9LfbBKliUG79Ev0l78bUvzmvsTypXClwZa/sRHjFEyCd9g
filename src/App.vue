<template>
  <AppHeader />
  <SvoNotification @open-svo-modal="openSvoModal" />
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
import { ref } from "vue";
import { RouterView } from "vue-router";
import AppHeader from "@/components/AppHeader.vue";
import AppFooter from "@/components/AppFooter.vue";
import ThemeToggle from "@/components/ThemeToggle.vue";
import SvoNotification from "@/components/SvoNotification.vue";
import ServiceModal from "@/components/ServiceModal.vue";
import { svoNotificationData } from "@/data/serviceDetails.js";

const isSvoModalVisible = ref(false);
const svoModalTitle = ref('');
const svoModalDescription = ref([]);

const openSvoModal = () => {
  svoModalTitle.value = svoNotificationData.title;
  svoModalDescription.value = svoNotificationData.detailedDescription;
  isSvoModalVisible.value = true;
};

const closeSvoModal = () => {
  isSvoModalVisible.value = false;
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
