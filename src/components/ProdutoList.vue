<template>
  <div class="min-h-screen bg-gray-900 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-7xl mx-auto">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-3xl font-extrabold text-white">Lista de Produtos</h2>
        <router-link to="/produtos/novo" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded">
          Novo Produto
        </router-link>
      </div>
      <div class="bg-gray-800 shadow overflow-hidden sm:rounded-md">
        <ul class="divide-y divide-gray-700">
          <li v-for="produto in produtos" :key="produto.id" class="px-6 py-4 flex items-center justify-between">
            <div>
              <div class="text-sm font-medium text-white">{{ produto.nome }}</div>
              <div class="text-sm text-gray-400">{{ produto.categoria.nome }}</div>
            </div>
            <div class="flex items-center space-x-4">
              <div class="text-sm font-medium text-green-400">R$ {{ produto.preco.toFixed(2) }}</div>
              <div class="flex space-x-2">
                <router-link :to="`/produtos/${produto.id}/editar`" class="text-indigo-400 hover:text-indigo-300">
                  Editar
                </router-link>
                <button @click="deleteProduto(produto.id)" class="text-red-400 hover:text-red-300">
                  Excluir
                </button>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getProdutos, deleteProduto as apiDeleteProduto } from '../api'

const produtos = ref([])

onMounted(async () => {
  await loadProdutos()
})

const loadProdutos = async () => {
  try {
    const response = await getProdutos()
    produtos.value = response.data
  } catch (error) {
    console.error('Erro ao carregar produtos:', error)
    // Adicione aqui a lógica para mostrar uma mensagem de erro ao usuário
  }
}

const deleteProduto = async (id) => {
  if (confirm('Tem certeza que deseja excluir este produto?')) {
    try {
      await apiDeleteProduto(id)
      await loadProdutos()
    } catch (error) {
      console.error('Erro ao excluir produto:', error)
      // Adicione aqui a lógica para mostrar uma mensagem de erro ao usuário
    }
  }
}
</script>

