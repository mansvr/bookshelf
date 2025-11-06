import { useBookStore } from '../store/bookStore'

export default function UI() {
  const { selectedBook, theme, setTheme, setSelectedBook } = useBookStore()

  return (
    <>
      {/* Theme Toggle */}
      <div style={styles.themeToggle}>
        <button
          onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}
          style={styles.themeButton}
        >
          {theme === 'light' ? '🌙' : '☀️'}
        </button>
      </div>

      {/* Instructions */}
      <div style={styles.instructions}>
        <h3 style={styles.instructionTitle}>🎮 Controls</h3>
        <p>🖱️ Drag to rotate</p>
        <p>🔍 Scroll to zoom</p>
        <p>👆 Click books to open</p>
      </div>

      {/* Book Details Panel */}
      {selectedBook && (
        <div style={styles.detailsPanel}>
          <button
            onClick={() => setSelectedBook(null)}
            style={styles.closeButton}
          >
            ✕
          </button>
          <h2 style={styles.bookTitle}>{selectedBook.title}</h2>
          <p style={styles.bookAuthor}>by {selectedBook.author}</p>
          {selectedBook.page_count && (
            <p style={styles.bookInfo}>📖 {selectedBook.page_count} pages</p>
          )}
          {selectedBook.description && (
            <p style={styles.bookDescription}>{selectedBook.description}</p>
          )}
          {selectedBook.file_path && (
            <a
              href={`/api/download/${encodeURIComponent(selectedBook.file_path)}`}
              target="_blank"
              rel="noopener noreferrer"
              style={styles.viewButton}
            >
              📚 View Book
            </a>
          )}
        </div>
      )}

      {/* Stats */}
      <div style={styles.stats}>
        <p>📚 Books: {useBookStore.getState().books.length}</p>
        <p>🎥 FOV: 21°</p>
      </div>
    </>
  )
}

const styles = {
  themeToggle: {
    position: 'fixed',
    top: '20px',
    right: '20px',
    zIndex: 1000,
  },
  themeButton: {
    background: 'rgba(255, 255, 255, 0.1)',
    backdropFilter: 'blur(10px)',
    border: '1px solid rgba(255, 255, 255, 0.2)',
    borderRadius: '50%',
    width: '50px',
    height: '50px',
    cursor: 'pointer',
    fontSize: '24px',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    transition: 'all 0.3s ease',
  },
  instructions: {
    position: 'fixed',
    top: '20px',
    left: '20px',
    background: 'rgba(0, 0, 0, 0.7)',
    backdropFilter: 'blur(10px)',
    padding: '15px 20px',
    borderRadius: '12px',
    color: 'white',
    fontSize: '14px',
    zIndex: 1000,
  },
  instructionTitle: {
    marginBottom: '10px',
    fontSize: '16px',
  },
  detailsPanel: {
    position: 'fixed',
    bottom: '20px',
    left: '50%',
    transform: 'translateX(-50%)',
    background: 'rgba(0, 0, 0, 0.9)',
    backdropFilter: 'blur(20px)',
    padding: '25px 30px',
    borderRadius: '16px',
    color: 'white',
    maxWidth: '500px',
    width: '90%',
    zIndex: 1000,
    boxShadow: '0 10px 40px rgba(0, 0, 0, 0.5)',
  },
  closeButton: {
    position: 'absolute',
    top: '10px',
    right: '10px',
    background: 'transparent',
    border: 'none',
    color: 'white',
    fontSize: '24px',
    cursor: 'pointer',
    padding: '5px',
  },
  bookTitle: {
    margin: '0 0 10px 0',
    fontSize: '24px',
    fontWeight: 'bold',
  },
  bookAuthor: {
    margin: '0 0 15px 0',
    fontSize: '16px',
    opacity: 0.8,
  },
  bookInfo: {
    margin: '10px 0',
    fontSize: '14px',
  },
  bookDescription: {
    margin: '15px 0',
    fontSize: '14px',
    lineHeight: '1.6',
    opacity: 0.9,
  },
  viewButton: {
    display: 'inline-block',
    marginTop: '15px',
    padding: '10px 20px',
    background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    color: 'white',
    textDecoration: 'none',
    borderRadius: '8px',
    fontSize: '14px',
    fontWeight: 'bold',
    transition: 'all 0.3s ease',
  },
  stats: {
    position: 'fixed',
    bottom: '20px',
    right: '20px',
    background: 'rgba(0, 0, 0, 0.7)',
    backdropFilter: 'blur(10px)',
    padding: '10px 15px',
    borderRadius: '12px',
    color: 'white',
    fontSize: '12px',
    zIndex: 1000,
  },
}

