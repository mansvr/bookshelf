export default function Bookshelf() {
  return (
    <group position={[0, 0, 0]}>
      {/* Circular platform for books */}
      <mesh position={[0, 0.05, 0]} receiveShadow>
        <cylinderGeometry args={[5.5, 5.5, 0.1, 64]} />
        <meshStandardMaterial color="#3d2817" roughness={0.7} metalness={0.2} />
      </mesh>

      {/* Center pedestal */}
      <mesh position={[0, 0.5, 0]} castShadow>
        <cylinderGeometry args={[0.3, 0.4, 1, 32]} />
        <meshStandardMaterial color="#4a3520" roughness={0.6} />
      </mesh>

      {/* Decorative top */}
      <mesh position={[0, 1.05, 0]} castShadow>
        <cylinderGeometry args={[0.35, 0.3, 0.1, 32]} />
        <meshStandardMaterial color="#5a4530" roughness={0.5} metalness={0.3} />
      </mesh>
    </group>
  )
}

