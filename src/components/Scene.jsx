import { OrbitControls, Environment, PerspectiveCamera, ContactShadows } from '@react-three/drei'
import { useEffect } from 'react'
import { useBookStore } from '../store/bookStore'
import Bookshelf from './Bookshelf'
import Book from './Book'

export default function Scene() {
  const { books, fetchBooks, loading } = useBookStore()

  useEffect(() => {
    fetchBooks()
  }, [fetchBooks])

  return (
    <>
      {/* Dramatic 21-degree FOV Camera with Orbit Controls */}
      <PerspectiveCamera makeDefault position={[0, 2, 15]} fov={21} />
      <OrbitControls
        enableDamping
        dampingFactor={0.05}
        minDistance={5}
        maxDistance={30}
        minPolarAngle={Math.PI / 6}
        maxPolarAngle={Math.PI / 2}
        target={[0, 1.5, 0]}
      />

      {/* Lighting Setup */}
      <ambientLight intensity={0.3} />
      <directionalLight
        position={[10, 10, 5]}
        intensity={1}
        castShadow
        shadow-mapSize={[2048, 2048]}
        shadow-camera-left={-10}
        shadow-camera-right={10}
        shadow-camera-top={10}
        shadow-camera-bottom={-10}
      />
      <spotLight
        position={[0, 8, 0]}
        angle={0.6}
        penumbra={0.5}
        intensity={0.5}
        castShadow
      />

      {/* Environment for reflections */}
      <Environment preset="apartment" />

      {/* Fog for depth */}
      <fog attach="fog" args={['#1a1a1a', 15, 50]} />

      {/* Contact shadows for realism */}
      <ContactShadows
        position={[0, 0, 0]}
        opacity={0.5}
        scale={20}
        blur={2}
        far={4}
      />

      {/* Bookshelf and Books */}
      {!loading && books.length > 0 && (
        <>
          <Bookshelf />
          {books.map((book, index) => (
            <Book key={book.id} book={book} index={index} totalBooks={books.length} />
          ))}
        </>
      )}

      {/* Ground plane */}
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[100, 100]} />
        <meshStandardMaterial color="#2a2a2a" roughness={0.8} />
      </mesh>
    </>
  )
}

