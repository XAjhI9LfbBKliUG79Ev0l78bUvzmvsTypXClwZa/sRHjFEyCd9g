<template>
  <main id="top">
    <section class="intro-section" aria-labelledby="intro-title-h1">
      <div class="container intro-container">
        <div class="intro-content">
          <div class="intro-text">
            <h1 class="intro-title" id="intro-title-h1">
              Квалифицированная юридическая помощь
            </h1>
            <p class="intro-location">
              Саратовская область | Возможен выезд по РФ <a href="#faq" class="marker-link" aria-label="Подробнее о выезде в другие регионы РФ в разделе Вопросы">(?)</a>
            </p>
            <ul class="intro-key-points" aria-label="Ключевые преимущества">
              <li>
                <IconCircleCheck class="key-point-icon" aria-hidden="true" />
                Опыт работы адвокатом с 1998 года
              </li>
              <li>
                <IconCircleCheck class="key-point-icon" aria-hidden="true" />
                Гарантия полной конфиденциальности
              </li>
            </ul>
            <a href="#contact" class="button intro-button"
              >Получить консультацию</a
            >
          </div>
          <div class="intro-visual">
            <img
              src="@/assets/photo.jpg"
              alt="Фотография Шкоды Алексея Игоревича"
              class="lawyer-photo"
              loading="lazy"
              width="256"
              height="256"
            />
            <div class="registry-info">
              <span class="registry-icon" aria-hidden="true">
                <IconCircleDashedCheck aria-hidden="true" />
              </span>
              <div>
                <p>Реестр адвокатов Адвокатской палаты Саратовской области</p>
                <a
                  href="https://ap64.ru/registry/shkoda-aleksey-igorevich/"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="registry-link"
                  aria-label="Проверить регистрационный номер 2344 в реестре"
                >
                  № 2344
                  <span class="link-indicator" aria-hidden="true">
                    <IconExternalLink />
                  </span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section
      id="services"
      class="services-section"
      aria-labelledby="services-title"
    >
      <div class="container">
        <h2 class="section-title" id="services-title">
          Направления юридической помощи
        </h2>
        <div class="services-grid">
          <ServiceCard
            v-for="service in services"
            :key="service.id"
            :title="service.title"
            :description="service.description"
            :icon-component="service.icon"
            :aria-id="'service-title-' + service.id"
            @card-click="openServiceModal(service)"
          />
        </div>
      </div>
    </section>

    <ServiceModal
      :is-visible="isServiceModalVisible"
      :title="currentServiceForModal?.title || ''"
      :formatted-detailed-description="
        currentServiceForModal?.detailedDescription || []
      "
      @close="closeServiceModal"
    />

    <section
      id="contact"
      class="contact-section"
      aria-labelledby="contact-title"
    >
      <div class="container">
        <h2 class="section-title" id="contact-title">Связь с адвокатом</h2>
        <div class="contact-wrapper">
          <div class="contact-info">
            <div class="confidentiality-badge-wrapper">
              <div class="confidentiality-badge">
                <IconLockAccess aria-hidden="true" />
                <span>Ваше обращение конфиденциально</span>
              </div>
            </div>
            <p>
              Для консультации и обсуждения дела свяжитесь удобным способом.
              Прием по предварительной договоренности.
            </p>
            <address class="contact-details">
              <div class="contact-item">
                <span class="contact-icon" aria-hidden="true">
                  <IconPhone aria-hidden="true" />
                </span>
                <div>
                  <h4>Телефон:</h4>
                  <p><a :href="`tel:${contactInfo.phoneNumber}`">{{ contactInfo.formattedPhoneNumber }}</a></p>
                </div>
              </div>
              <div class="contact-item">
                <span class="contact-icon" aria-hidden="true">
                  <IconMail aria-hidden="true" />
                </span>
                <div>
                  <h4>Email:</h4>
                  <p>
                    <a
                      :href="`mailto:${contactInfo.emailAddress}?subject=%D0%97%D0%B0%D0%BF%D1%80%D0%BE%D1%81%20%D1%8E%D1%80%D0%B8%D0%B4%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B9%20%D0%BA%D0%BE%D0%BD%D1%81%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%86%D0%B8%D0%B8&body=%D0%97%D0%B4%D1%80%D0%B0%D0%B2%D1%81%D1%82%D0%B2%D1%83%D0%B9%D1%82%D0%B5%2C%20%D0%90%D0%BB%D0%B5%D0%BA%D1%81%D0%B5%D0%B9%20%D0%98%D0%B3%D0%BE%D1%80%D0%B5%D0%B2%D0%B8%D1%87.%0A%0A%D0%9E%D0%BF%D0%B8%D1%88%D0%B8%D1%82%D0%B5%20%D0%BA%D1%80%D0%B0%D1%82%D0%BA%D0%BE%20%D0%92%D0%B0%D1%88%D1%83%20%D1%81%D0%B8%D1%82%D1%83%D0%B0%D1%86%D0%B8%D1%8E%20%D0%B8%20%D0%B6%D0%B5%D0%BB%D0%B0%D0%B5%D0%BC%D0%BE%D0%B5%20%D0%B2%D1%80%D0%B5%D0%BC%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D1%81%D0%B2%D1%8F%D0%B7%D0%B8.%0A%0A%D0%A1%20%D1%83%D0%B2%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%D0%BC%2C%0A%5B%D0%92%D0%B0%D1%88%D0%B5%20%D0%B8%D0%BC%D1%8F%5D%0A%5B%D0%92%D0%B0%D1%88%20%D0%BA%D0%BE%D0%BD%D1%82%D0%B0%D0%BA%D1%82%D0%BD%D1%8B%D0%B9%20%D1%82%D0%B5%D0%BB%D0%B5%D1%84%D0%BE%D0%BD%5D`"
                      >{{ contactInfo.emailAddress }}</a
                    >
                  </p>
                </div>
              </div>
              <div class="contact-item">
                <span class="contact-icon" aria-hidden="true">
                  <IconMessageCircle aria-hidden="true" />
                </span>
                <div>
                  <h4>Signal (защищенная связь):</h4>
                  <p>
                    <a
                      :href="contactInfo.signalLink"
                      target="_blank"
                      rel="noopener noreferrer"
                      >Написать в Signal</a
                    >
                  </p>
                </div>
              </div>
              <div class="contact-item">
                <span class="contact-icon" aria-hidden="true">
                  <IconMapPin aria-hidden="true" />
                </span>
                <div>
                  <h4>Место приема:</h4>
                  <p>
                    {{ contactInfo.workAddress }}<br />(Возможен выезд
                    по РФ)
                  </p>
                </div>
              </div>
            </address>
          </div>
        </div>
      </div>
    </section>

    <section id="faq" class="faq-section" aria-labelledby="faq-title">
      <div class="container">
        <h2 class="section-title" id="faq-title">Часто задаваемые вопросы</h2>
        <div class="faq-list">
          <FaqItem
            v-for="faq in faqs"
            :key="faq.id"
            :question="faq.question"
            :answer="faq.answer"
          />
        </div>
      </div>
    </section>
  </main>
</template>

<script setup>
import { ref, shallowRef, computed } from "vue";
import { RouterLink } from "vue-router";
import {
  servicesData as importedServicesData,
  faqsData,
} from "@/data/serviceDetails.js";
import { contactInfo } from '@/config/contactInfo.js';

import ServiceCard from "@/components/ServiceCard.vue";
import ServiceModal from "@/components/ServiceModal.vue";
import FaqItem from "@/components/FaqItem.vue";

import IconCircleDashedCheck from "@/components/icons/IconCircleDashedCheck.vue";
import IconGavel from "@/components/icons/IconGavel.vue";
import IconUsers from "@/components/icons/IconUsers.vue";
import IconBriefcase from "@/components/icons/IconBriefcase.vue";
import IconScale from "@/components/icons/IconScale.vue";
import IconLockAccess from "@/components/icons/IconLockAccess.vue";
import IconPhone from "@/components/icons/IconPhone.vue";
import IconMail from "@/components/icons/IconMail.vue";
import IconMessageCircle from "@/components/icons/IconMessageCircle.vue";
import IconMapPin from "@/components/icons/IconMapPin.vue";

const iconMap = {
  IconGavel: IconGavel,
  IconUsers: IconUsers,
  IconBriefcase: IconBriefcase,
  IconScale: IconScale,
};

const services = computed(() =>
  importedServicesData.map((service) => ({
    ...service,
    icon: iconMap[service.iconComponent] || IconGavel,
  })),
);

const faqs = ref(faqsData);

const isServiceModalVisible = ref(false);
const currentServiceForModal = ref(null);

const openServiceModal = (service) => {
  currentServiceForModal.value = service;
  isServiceModalVisible.value = true;
};

const closeServiceModal = () => {
  isServiceModalVisible.value = false;
};

</script>

<style scoped>
.intro-section {
  background-color: var(--color-bg-white);
  transition: background-color var(--transition-base);
  padding-block: var(--spacing-lg);
}
.intro-container {
}
.intro-content {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--spacing-lg);
  align-items: center;
  text-align: center;
}
.intro-text {
  order: 2;
  text-align: center;
}
.intro-title {
  margin-block-end: var(--spacing-sm);
}
.intro-location {
  font-size: var(--font-size-base);
  font-weight: 600;
  color: var(--color-text-muted);
  margin-block-end: var(--spacing-md);
  transition: color var(--transition-base);
}
.intro-location a {
  color: var(--color-primary-dark);
  text-decoration: underline;
  text-underline-offset: 2px;
}
.intro-location a:hover,
.intro-location a:focus-visible {
  color: var(--color-primary);
}
.intro-key-points {
  padding-inline-start: 0;
  margin-block-start: var(--spacing-md);
  margin-block-end: var(--spacing-lg);
  display: inline-flex;
  flex-direction: column;
  gap: var(--spacing-sm);
  align-items: flex-start;
  text-align: left;
}
.intro-key-points li {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
  font-size: var(--font-size-base);
}
.key-point-icon {
  inline-size: 1.375rem;
  block-size: 1.375rem;
  color: var(--color-primary-dark);
  transition: color var(--transition-base);
  flex-shrink: 0;
}
.intro-button {
  font-size: 1.05rem;
  margin-block-start: var(--spacing-md);
}
.intro-visual {
  order: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-md);
}
.lawyer-photo {
  inline-size: clamp(10rem, 40vw, 15rem);
  block-size: clamp(10rem, 40vw, 15rem);
  object-fit: cover;
  border-radius: 50%;
  background-color: var(--color-border-light);
  box-shadow: var(--shadow-photo);
  border: 5px solid var(--color-bg-white);
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base),
    box-shadow var(--transition-base);
}
.registry-info {
  background-color: var(--color-primary-lighter);
  border: var(--border-width) solid var(--color-primary-light);
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--border-radius-lg);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-xs);
  font-size: 0.875rem;
  max-width: 300px;
  text-align: center;
  box-shadow: var(--shadow-md);
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base),
    box-shadow var(--transition-base),
    color var(--transition-base);
  align-self: center;
}
.registry-icon {
  color: var(--color-primary-dark);
  transition: color var(--transition-base);
  flex-shrink: 0;
  margin-bottom: var(--spacing-xs);
}
.registry-icon svg {
  inline-size: 2rem;
  block-size: 2rem;
}
.registry-info > div {
  text-align: center;
}
.registry-info p {
  margin: 0;
  color: var(--color-text-muted);
  font-size: var(--font-size-xs);
  line-height: 1.4;
  transition: color var(--transition-base);
  margin-block-start: var(--spacing-xs);
}
.registry-link {
  font-weight: 700;
  font-size: 1rem;
  color: var(--color-primary-dark);
  display: inline-flex;
  align-items: center;
  gap: var(--spacing-xs);
  padding-block: 0;
  margin-block-start: var(--spacing-xs);
  transition: color var(--transition-base);
}
.registry-link:hover,
.registry-link:focus {
  opacity: 1;
}
.link-indicator svg {
  inline-size: 0.8em;
  block-size: 0.8em;
  opacity: 0.7;
  transition: transform var(--transition-fast);
  vertical-align: baseline;
}
.registry-link:hover .link-indicator svg,
.registry-link:focus .link-indicator svg {
  transform: translate(2px, -2px);
}

.services-section {
  background-color: var(--color-primary-lighter);
  border-block: var(--border-width) solid var(--color-border-light);
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base);
}
.services-grid {
  display: grid;
  gap: var(--spacing-lg);
  grid-template-columns: 1fr;
}

.cases-section {
  background-color: var(--color-bg-white);
  transition: background-color var(--transition-base);
}
.cases-tabs {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: var(--spacing-sm);
  margin-block-end: var(--spacing-lg);
}
.cases-tabs input[type="radio"] {
  position: absolute;
  opacity: 0;
  pointer-events: none;
  inline-size: 1px;
  block-size: 1px;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
.tab-button {
  display: inline-block;
  padding: calc(var(--spacing-sm) * 0.9) var(--spacing-md);
  border: var(--border-width) solid var(--color-border);
  border-radius: var(--border-radius-full);
  cursor: pointer;
  transition:
    background-color var(--transition-base),
    color var(--transition-base),
    border-color var(--transition-base),
    box-shadow var(--transition-base);
  font-weight: 600;
  background-color: var(--color-bg-white);
  color: var(--color-secondary);
  user-select: none;
  line-height: 1.3;
  white-space: nowrap;
  font-size: 0.9375rem;
}
.cases-tabs input[type="radio"]:checked + .tab-button {
  background-color: var(--color-primary);
  color: var(--color-text-inverse);
  border-color: var(--color-primary);
  box-shadow: var(--shadow-sm);
}
.cases-tabs input[type="radio"]:focus {
  outline: none;
}
.cases-tabs input[type="radio"]:focus-visible + .tab-button {
  box-shadow:
    0 0 0 2px var(--color-bg-white),
    0 0 0 4px var(--color-focus);
  border-color: var(--color-focus);
}
.cases-content-wrapper {
  position: relative;
  overflow: hidden;
  margin-inline: calc(-1 * var(--spacing-sm));
  width: calc(100% + 2 * var(--spacing-sm));
  order: 99;
  margin-block-start: var(--spacing-lg);
}
.cases-panel {
  padding-inline: var(--spacing-sm);
}
.cases-grid.horizontal-scroll {
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: minmax(270px, 85%);
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  scroll-padding-inline: var(--spacing-sm);
  gap: var(--spacing-lg);
  padding-block-end: var(--spacing-md);
  padding-inline: var(--spacing-sm);
  -webkit-overflow-scrolling: touch;
  scrollbar-width: thin;
  scrollbar-color: var(--color-border) var(--color-bg-light);
  transition: scrollbar-color var(--transition-base);
}
.cases-grid.horizontal-scroll::-webkit-scrollbar {
  height: 10px;
}
.cases-grid.horizontal-scroll::-webkit-scrollbar-track {
  background: var(--color-bg-light);
  border-radius: 5px;
  margin-inline: var(--spacing-sm);
  transition: background-color var(--transition-base);
}
.cases-grid.horizontal-scroll::-webkit-scrollbar-thumb {
  background-color: var(--color-border);
  border-radius: 5px;
  border: 2px solid var(--color-bg-light);
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base);
}
.cases-grid.horizontal-scroll::-webkit-scrollbar-thumb:hover {
  background-color: var(--color-secondary);
}
.archive-link-wrapper {
  text-align: center;
  margin-block-start: var(--spacing-lg);
}
.archive-link {
  display: inline-flex;
  align-items: center;
  gap: var(--spacing-sm);
  font-weight: 600;
  color: var(--color-primary-dark);
  text-decoration: underline;
  text-underline-offset: 4px;
  transition: color var(--transition-base);
  font-size: 1rem;
}
.archive-link svg {
  inline-size: 1.2em;
  block-size: 1.2em;
  transition: color var(--transition-base);
}
.archive-link:hover,
.archive-link:focus {
  color: var(--color-primary);
  opacity: 1;
}
.disclaimer {
  font-size: var(--font-size-sm);
  color: var(--color-text-muted);
  text-align: center;
  max-width: none;
  margin-block-start: var(--spacing-sm);
  margin-block-end: 0;
  transition: color var(--transition-base);
  line-height: 1.5;
}

.contact-section {
  background-color: var(--color-primary-lighter);
  border-block-start: var(--border-width) solid var(--color-border-light);
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base);
}
.contact-wrapper {
  max-width: 720px;
  margin-inline: auto;
  background-color: var(--color-bg-white);
  padding: clamp(
    var(--spacing-lg),
    6vw,
    var(--spacing-xl)
  );
  border-radius: var(--border-radius-xl);
  box-shadow: var(--shadow-lg);
  position: relative;
  transition:
    background-color var(--transition-base),
    box-shadow var(--transition-base);
}
.contact-info {
}
.confidentiality-badge-wrapper {
  text-align: center;
  margin-block-end: var(--spacing-lg);
}
.confidentiality-badge {
  background-color: var(--color-primary-lighter);
  border: var(--border-width) solid var(--color-primary-light);
  color: var(--color-primary-dark);
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--border-radius-lg);
  display: inline-flex;
  align-items: center;
  gap: var(--spacing-sm);
  font-size: 0.9375rem;
  font-weight: 600;
  width: fit-content;
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base),
    color var(--transition-base);
}
.confidentiality-badge svg {
  inline-size: 1.375rem;
  block-size: 1.375rem;
}
.contact-info > p:nth-of-type(1) {
  font-size: var(--font-size-base);
  color: var(--color-text-muted);
  text-align: center;
  margin-block-start: 0;
  margin-block-end: var(--spacing-lg);
  max-width: 60ch;
  margin-inline: auto;
  transition: color var(--transition-base);
}
.contact-details {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-lg);
}
.contact-item {
  display: flex;
  align-items: flex-start;
  gap: var(--spacing-md);
}
.contact-icon {
  color: var(--color-primary-dark);
  background-color: var(--color-primary-lighter);
  padding: var(--spacing-sm);
  border-radius: 50%;
  flex-shrink: 0;
  margin-top: 0.15em;
  transition:
    color var(--transition-base),
    background-color var(--transition-base);
  display: inline-flex;
  justify-content: center;
  align-items: center;
}
.contact-icon svg {
  inline-size: 1.625rem;
  block-size: 1.625rem;
}
.contact-item h4 {
  font-size: var(--font-size-xs);
  font-weight: 600;
  margin-block-end: var(--spacing-xs);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.075em;
  transition: color var(--transition-base);
}
.contact-item p {
  font-size: var(--font-size-base);
  font-weight: 600;
  color: var(--color-text-base);
  line-height: 1.45;
  margin: 0;
  transition: color var(--transition-base);
}
.contact-item a {
  color: var(--color-primary-dark);
  transition: color var(--transition-base);
  text-decoration: none;
}
.contact-item a:hover,
.contact-item a:focus {
  color: var(--color-primary);
  opacity: 1;
  text-decoration: underline;
}

.faq-section {
  background-color: var(--color-bg-light);
  border-block-start: var(--border-width) solid var(--color-border-light);
  padding-block-end: clamp(var(--spacing-xl), 10vw, var(--spacing-xxl));
  transition:
    background-color var(--transition-base),
    border-color var(--transition-base);
}
.faq-list {
  max-width: 800px;
  margin-inline: auto;
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.marker-link {
  text-decoration: none;
  font-size: 0.8em;
  color: var(--color-secondary);
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius-sm);
  padding: 0.1em 0.4em;
  margin-left: var(--spacing-xs);
  transition: all var(--transition-fast);
  display: inline-block;
  line-height: 1;
}

.marker-link:hover,
.marker-link:focus {
  background-color: var(--color-primary-lighter);
  color: var(--color-primary-dark);
  border-color: var(--color-primary);
  text-decoration: none;
  opacity: 1;
  box-shadow: var(--shadow-sm);
}

.marker-link:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 1px;
}

.dark-theme .marker-link {
  color: var(--color-secondary-dark-theme);
  border-color: var(--color-border-dark-theme);
}

.dark-theme .marker-link:hover,
.dark-theme .marker-link:focus {
  background-color: var(--color-primary-lighter-dark-theme);
  color: var(--color-primary-dark-dark-theme);
  border-color: var(--color-primary-dark-theme);
  box-shadow: var(--shadow-sm-dark);
}

.dark-theme .marker-link:focus-visible {
  outline-color: var(--color-focus-dark-theme);
}

.dark-theme .intro-section {
  background-color: var(--color-bg-white-dark-theme);
}
.dark-theme .intro-location {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .intro-location a {
  color: var(--color-primary-dark-theme);
}
.dark-theme .intro-location a:hover,
.dark-theme .intro-location a:focus-visible {
  color: var(--color-primary-dark-dark-theme);
}
.dark-theme .key-point-icon {
  color: var(--color-primary-dark-theme);
}
.dark-theme .lawyer-photo {
  background-color: var(--color-border-dark-theme);
  box-shadow: var(--shadow-photo-dark);
  border-color: var(--color-bg-white-dark-theme);
}
.dark-theme .registry-info {
  background-color: var(--color-primary-lighter-dark-theme);
  border-color: var(--color-primary-light-dark-theme);
  box-shadow: var(--shadow-md-dark);
}
.dark-theme .registry-icon {
  color: var(--color-primary-dark-theme);
}
.dark-theme .registry-info p {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .registry-link {
  color: var(--color-primary-dark-theme);
}

.dark-theme .services-section {
  background-color: var(--color-primary-lighter-dark-theme);
  border-color: var(--color-border-light-dark-theme);
}

.dark-theme .cases-section {
  background-color: var(--color-bg-white-dark-theme);
}
.dark-theme .tab-button {
  border-color: var(--color-border-dark-theme);
  background-color: var(--color-bg-white-dark-theme);
  color: var(--color-secondary-dark-theme);
}
.dark-theme .cases-tabs input[type="radio"]:checked + .tab-button {
  background-color: var(--color-primary-dark-theme);
  color: var(--color-text-inverse-dark-theme);
  border-color: var(--color-primary-dark-theme);
  box-shadow: var(--shadow-sm-dark);
}
.dark-theme .cases-tabs input[type="radio"]:focus-visible + .tab-button {
  box-shadow:
    0 0 0 2px var(--color-bg-white-dark-theme),
    0 0 0 4px var(--color-focus-dark-theme);
  border-color: var(--color-focus-dark-theme);
}
.dark-theme .cases-grid.horizontal-scroll {
  scrollbar-color: var(--color-border-dark-theme)
    var(--color-bg-light-dark-theme);
}
.dark-theme .cases-grid.horizontal-scroll::-webkit-scrollbar-track {
  background: var(--color-bg-light-dark-theme);
}
.dark-theme .cases-grid.horizontal-scroll::-webkit-scrollbar-thumb {
  background-color: var(--color-border-dark-theme);
  border-color: var(--color-bg-light-dark-theme);
}
.dark-theme .cases-grid.horizontal-scroll::-webkit-scrollbar-thumb:hover {
  background-color: var(--color-secondary-dark-theme);
}
.dark-theme .archive-link {
  color: var(--color-primary-dark-theme);
}
.dark-theme .archive-link:hover,
.dark-theme .archive-link:focus {
  color: var(--color-primary-dark-dark-theme);
}
.dark-theme .disclaimer {
  color: var(--color-text-muted-dark-theme);
}

.dark-theme .contact-section {
  background-color: var(--color-primary-lighter-dark-theme);
  border-color: var(--color-border-light-dark-theme);
}
.dark-theme .contact-wrapper {
  background-color: var(--color-bg-white-dark-theme);
  box-shadow: var(--shadow-lg-dark);
}
.dark-theme .contact-info > p:nth-of-type(1) {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .confidentiality-badge {
  background-color: var(--color-primary-lighter-dark-theme);
  border-color: var(--color-primary-light-dark-theme);
  color: var(--color-primary-dark-theme);
}
.dark-theme .contact-icon {
  color: var(--color-primary-dark-theme);
  background-color: var(--color-primary-lighter-dark-theme);
}
.dark-theme .contact-item h4 {
  color: var(--color-text-muted-dark-theme);
}
.dark-theme .contact-item p {
  color: var(--color-text-base-dark-theme);
}
.dark-theme .contact-item a {
  color: var(--color-primary-dark-theme);
}
.dark-theme .contact-item a:hover,
.dark-theme .contact-item a:focus {
  color: var(--color-primary-dark-dark-theme);
}

.dark-theme .faq-section {
  background-color: var(--color-bg-light-dark-theme);
  border-color: var(--color-border-light-dark-theme);
}

@media (min-width: 768px) {
  .intro-section {
    padding-block: clamp(var(--spacing-lg), 8vw, var(--spacing-xl));
  }
  .intro-content {
    grid-template-columns: 1fr 0.7fr;
    gap: var(--spacing-xl);
    text-align: left;
  }
  .intro-text {
    order: 1;
    text-align: left;
  }
  .intro-key-points {
    display: flex;
    align-items: flex-start;
  }
  .intro-visual {
    order: 2;
    align-items: center;
    gap: var(--spacing-lg);
  }
  .lawyer-photo {
    inline-size: clamp(12rem, 30vw, 16rem);
    block-size: clamp(12rem, 30vw, 16rem);
    border-width: 6px;
  }
  .registry-info {
    flex-direction: row;
    text-align: left;
    align-items: center;
    max-width: 340px;
    gap: var(--spacing-sm);
    padding: var(--spacing-md);
  }
  .registry-info p {
    margin-block-start: 0;
  }

  .services-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-lg);
  }

  .tab-button {
    padding: var(--spacing-sm) var(--spacing-lg);
    font-size: 1rem;
  }
  .cases-content-wrapper {
    margin-inline: calc(-1 * var(--spacing-lg));
    width: calc(100% + 2 * var(--spacing-lg));
  }
  .cases-panel {
    padding-inline: var(--spacing-lg);
  }
  .cases-grid.horizontal-scroll {
    grid-auto-columns: minmax(320px, 1fr);
    gap: var(--spacing-lg);
    scroll-padding-inline: var(--spacing-lg);
    padding-inline: var(--spacing-lg);
  }
  .cases-grid.horizontal-scroll::-webkit-scrollbar-track {
    margin-inline: var(--spacing-lg);
  }
}

@media (max-width: 480px) {
  .cases-grid.horizontal-scroll {
    grid-auto-columns: minmax(250px, 90%);
  }
  .intro-key-points {
    align-items: flex-start;
  }
  .intro-location,
  .intro-title {
    text-align: center;
  }
  .intro-text {
    text-align: center;
  }
  .intro-key-points {
    margin-left: auto;
    margin-right: auto;
  }
  .lawyer-photo {
    inline-size: clamp(10rem, 45vw, 14rem);
    block-size: clamp(10rem, 45vw, 14rem);
  }
  .registry-info {
    max-width: 260px;
  }
  .registry-link {
    font-size: 0.875rem;
  }
}
</style>
