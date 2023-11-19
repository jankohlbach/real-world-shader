export const resizeShaderCanvas = (canvas: HTMLCanvasElement, gl: WebGL2RenderingContext, fixedRatio: number | null = null) => {
  if (canvas) {
    canvas.width = window.innerWidth * (fixedRatio || Math.min(window.devicePixelRatio, 2))
    canvas.height = window.innerHeight * (fixedRatio || Math.min(window.devicePixelRatio, 2))
    canvas.style.width = `${window.innerWidth}px`
    canvas.style.height = `${window.innerHeight}px`

    gl.viewport(0, 0, gl.canvas.width, gl.canvas.height)
  }
}

export const createShader = (gl: WebGL2RenderingContext, type: number, code: string) => {
  const shader = gl.createShader(type)

  if (!shader) {
    throw new Error('Failed to create shader')
  }

  gl.shaderSource(shader, code)
  gl.compileShader(shader)

  if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
    throw new Error('Failed to compile shader: ' + gl.getShaderInfoLog(shader))
  }

  return shader
}

export const createShaderProgram = (gl: WebGL2RenderingContext, vertexShaderCode: string, fragmentShaderCode: string) => {
  const vertexShader = createShader(gl, gl.VERTEX_SHADER, vertexShaderCode)
  const fragmentShader = createShader(gl, gl.FRAGMENT_SHADER, fragmentShaderCode)

  const program = gl.createProgram()

  if (!program) {
    throw new Error('Failed to create program')
  }

  gl.attachShader(program, vertexShader)
  gl.attachShader(program, fragmentShader)
  gl.linkProgram(program)
  gl.useProgram(program)

  if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
    throw new Error('Failed to link shader program: ' + gl.getProgramInfoLog(program))
  }

  return program
}
