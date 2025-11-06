import { useBookStore } from '../store/bookStore'

export default function LoadingScreen() {
  const loading = useBookStore(state => state.loading)

  if (!loading) return null

  return (
    <div style={styles.container}>
      <div style={styles.loader}>
        <div style={styles.book}>
          <div style={styles.page}></div>
          <div style={styles.page}></div>
          <div style={styles.page}></div>
        </div>
        <h2 style={styles.text}>Loading your library...</h2>
        <p style={styles.subtext}>Preparing 3D experience</p>
      </div>
    </div>
  )
}

const styles = {
  container: {
    position: 'fixed',
    top: 0,
    left: 0,
    width: '100vw',
    height: '100vh',
    background: 'linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 100%)',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 9999,
  },
  loader: {
    textAlign: 'center',
  },
  book: {
    width: '60px',
    height: '80px',
    margin: '0 auto 30px',
    position: 'relative',
    transformStyle: 'preserve-3d',
    animation: 'bookFlip 2s infinite ease-in-out',
  },
  page: {
    width: '60px',
    height: '80px',
    background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    position: 'absolute',
    borderRadius: '0 4px 4px 0',
    transformOrigin: 'left center',
  },
  text: {
    color: 'white',
    fontSize: '24px',
    marginBottom: '10px',
  },
  subtext: {
    color: '#999',
    fontSize: '14px',
  },
}

