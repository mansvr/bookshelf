import { useRef, useState } from 'react'
import { useFrame } from '@react-three/fiber'
import { Text, useTexture } from '@react-three/drei'
import * as THREE from 'three'
import { useBookStore } from '../store/bookStore'

export default function Book({ book, index, totalBooks }) {
  const meshRef = useRef()
  const [hovered, setHovered] = useState(false)
  const [opened, setOpened] = useState(false)
  const setSelectedBook = useBookStore(state => state.setSelectedBook)

  // Calculate position in a circular arrangement
  const angle = (index / totalBooks) * Math.PI * 2
  const radius = 5
  const x = Math.sin(angle) * radius
  const z = Math.cos(angle) * radius

  // Book dimensions based on aspect ratio
  const bookWidth = 0.15
  const bookHeight = book.aspect_ratio ? bookWidth / book.aspect_ratio : 0.22
  const thickness = book.nonlinear_thickness ? book.nonlinear_thickness * 0.001 : 0.05

  // Animation
  useFrame((state) => {
    if (meshRef.current) {
      if (hovered) {
        meshRef.current.position.y = THREE.MathUtils.lerp(meshRef.current.position.y, 1.3, 0.1)
        meshRef.current.rotation.y = THREE.MathUtils.lerp(meshRef.current.rotation.y, angle + Math.PI, 0.1)
      } else if (opened) {
        meshRef.current.rotation.y = THREE.MathUtils.lerp(meshRef.current.rotation.y, angle + Math.PI + Math.PI * 0.5, 0.1)
      } else {
        meshRef.current.position.y = THREE.MathUtils.lerp(meshRef.current.position.y, 1, 0.1)
        meshRef.current.rotation.y = THREE.MathUtils.lerp(meshRef.current.rotation.y, angle + Math.PI, 0.1)
      }
    }
  })

  const handleClick = () => {
    setOpened(!opened)
    setSelectedBook(opened ? null : book)
  }

  return (
    <group position={[x, 1, z]}>
      <mesh
        ref={meshRef}
        castShadow
        receiveShadow
        onClick={handleClick}
        onPointerOver={() => setHovered(true)}
        onPointerOut={() => setHovered(false)}
      >
        {/* Book cover */}
        <boxGeometry args={[bookWidth, bookHeight, thickness]} />
        <meshStandardMaterial
          color={book.cover_color || '#8B4513'}
          roughness={0.6}
          metalness={0.1}
        />
      </mesh>

      {/* Spine text */}
      <Text
        position={[-bookWidth / 2 - 0.001, 0, 0]}
        rotation={[0, -Math.PI / 2, 0]}
        fontSize={0.02}
        maxWidth={bookHeight * 0.9}
        textAlign="center"
        color={book.cover_contrast || '#ffffff'}
      >
        {book.title}
      </Text>

      {/* Author text on spine */}
      <Text
        position={[-bookWidth / 2 - 0.001, -bookHeight * 0.3, 0]}
        rotation={[0, -Math.PI / 2, 0]}
        fontSize={0.015}
        maxWidth={bookHeight * 0.9}
        textAlign="center"
        color={book.cover_contrast || '#ffffff'}
      >
        {book.author}
      </Text>

      {/* Front cover (only visible when opened) */}
      {opened && (
        <mesh position={[0, 0, thickness / 2 + 0.001]}>
          <planeGeometry args={[bookWidth, bookHeight]} />
          <meshStandardMaterial
            color={book.cover_color || '#8B4513'}
            roughness={0.4}
          />
        </mesh>
      )}
    </group>
  )
}

