import { create } from 'zustand'

export const useBookStore = create((set) => ({
  books: [],
  selectedBook: null,
  loading: true,
  error: null,
  theme: 'dark',

  fetchBooks: async () => {
    try {
      set({ loading: true })
      // Fetch from Ruby backend
      const response = await fetch('/api/books.json')
      if (!response.ok) throw new Error('Failed to fetch books')
      const data = await response.json()
      set({ books: data, loading: false })
    } catch (error) {
      console.error('Error fetching books:', error)
      set({ error: error.message, loading: false })
      // Fallback to mock data for development
      set({
        books: generateMockBooks(),
        loading: false
      })
    }
  },

  setSelectedBook: (book) => set({ selectedBook: book }),
  setTheme: (theme) => set({ theme }),
}))

// Mock data for development/testing
function generateMockBooks() {
  const colors = ['#8B4513', '#2C1810', '#654321', '#4A3520', '#5C4033', '#3D2817']
  const books = []
  
  for (let i = 0; i < 20; i++) {
    books.push({
      id: i,
      title: `Book ${i + 1}`,
      author: `Author ${i + 1}`,
      cover_color: colors[i % colors.length],
      cover_contrast: '#ffffff',
      aspect_ratio: 0.67 + Math.random() * 0.1,
      nonlinear_thickness: 30 + Math.random() * 40,
      description: `This is a description for Book ${i + 1}. Lorem ipsum dolor sit amet, consectetur adipiscing elit.`,
      page_count: Math.floor(200 + Math.random() * 400)
    })
  }
  
  return books
}

