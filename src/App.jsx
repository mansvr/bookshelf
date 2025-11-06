import { Canvas } from '@react-three/fiber'
import { Suspense } from 'react'
import Scene from './components/Scene'
import UI from './components/UI'
import LoadingScreen from './components/LoadingScreen'

export default function App() {
  return (
    <>
      <Canvas
        shadows
        gl={{ antialias: true, alpha: false }}
        camera={{ 
          position: [0, 2, 15], 
          fov: 21, // Dramatic narrow field of view
          near: 0.1,
          far: 1000
        }}
      >
        <Suspense fallback={null}>
          <Scene />
        </Suspense>
      </Canvas>
      <UI />
      <LoadingScreen />
    </>
  )
}

