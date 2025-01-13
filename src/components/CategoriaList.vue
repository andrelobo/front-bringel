<template>
  <div>
    <h1 class="text-2xl font-bold mb-4">Categorias</h1>
    <p v-if="errorMessage" class="text-red-500">{{ errorMessage }}</p>
    <p v-else-if="categorias.length === 0" class="text-gray-500">Nenhuma categoria encontrada.</p>
    <ul v-else class="list-disc pl-5">
      <li v-for="categoria in categorias" :key="categoria.id" class="text-gray-800">
        {{ categoria.nome }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getCategorias } from '../api'

const categorias = ref([])
const errorMessage = ref('')

onMounted(async () => {
  try {
    const response = await getCategorias()
    console.log('Response da API:', response.data)
    if (response.data.success) {
      categorias.value = response.data.data
    } else {
      errorMessage.value = 'Erro ao carregar categorias. Resposta inesperada.'
    }
  } catch (error) {
    console.error('Erro ao buscar categorias:', error)
    errorMessage.value = 'Erro ao carregar categorias. Por favor, tente novamente mais tarde.'
  }
})
</script>

<style scoped>
/* Adicione estilos personalizados, se necessário */
</style>
