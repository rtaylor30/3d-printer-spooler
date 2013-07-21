//= require three.js
//= require Detector.js
//= require STLLoader.js
//= require stats.min.js

(function() {
  if ( ! Detector.webgl ) Detector.addGetWebGLMessage();
  
  var container, stats;
  var geometry, camera, center, scene, renderer, mesh, printbox, printbox_geo, cameraPositionScalar;
  
  init_stl_previewer = function(stl_file_name) {
    container = document.createElement( 'div' );
    $('.stl-preview').empty();
    $('.stl-preview').append(container);
    camera = new THREE.PerspectiveCamera( 30, window.innerWidth / window.innerHeight, 1, 1000 );
    scene = new THREE.Scene();
    scene.fog = new THREE.Fog( 0x72645b, 2, 1000 );
    center =  new THREE.Vector3(0,0,0);
    cameraPositionScalar = 500;
    
    var material = new THREE.MeshPhongMaterial( { ambient: 0xff5533, color: 0xff5533, specular: 0x111111, shininess: 200 } );
    printbox_geo = new THREE.CubeGeometry(190,100,200);
    printbox_geo.applyMatrix((new THREE.Matrix4()).makeTranslation(0, 50, 0));
    printbox = new THREE.Mesh(printbox_geo, new THREE.MeshBasicMaterial({ wireframe: 1})); 
    scene.add( printbox );
    
    loader = new THREE.STLLoader();
    loader.addEventListener( 'load', function ( event ) {
      geometry = event.content;
      mesh = new THREE.Mesh( geometry, material);
      scene.add( mesh );
      geometry.computeBoundingBox();
      center.copy(geometry.boundingBox.center());
      var transrot_matrix = (new THREE.Matrix4()).makeRotationX(-Math.PI/2);
      transrot_matrix.multiply((new THREE.Matrix4()).makeTranslation(-center.x, -center.y, -geometry.boundingBox.min.z));
      geometry.applyMatrix(transrot_matrix);
      mesh.receiveShadow = true;
      mesh.castShadow = true;
    });
    
    loader.load( stl_file_name );
    
    scene.add( new THREE.AmbientLight( 0x404040 ) );
    addShadowedLight( 1, 1, 1, 0xffffff, 1.35 );
    addShadowedLight( 0.5, 1, -1, 0xffaa00, 1 );
    
    renderer = new THREE.WebGLRenderer( { antialias: true, alpha: false } );
    renderer.setSize( 800, 600 );
    
    renderer.gammaInput = true;
    renderer.gammaOutput = true;
    renderer.physicallyBasedShading = true;
    
    renderer.shadowMapEnabled = true;
    renderer.shadowMapCullFace = THREE.CullFaceBack;
    
    container.appendChild( renderer.domElement );
    
    stats = new Stats();
    stats.domElement.style.position = 'absolute';
    stats.domElement.style.top = '0px';
    container.appendChild( stats.domElement );

    animate();
  }
  
  function animate() {
    requestAnimationFrame( animate );
    render();
    stats.update();
  }

  function addShadowedLight( x, y, z, color, intensity ) {
    var directionalLight = new THREE.DirectionalLight( color, intensity );
    directionalLight.position.set( x, y, z )
    scene.add( directionalLight );
    
    directionalLight.castShadow = true;
    
    var d = 1;
    directionalLight.shadowCameraLeft = -d;
    directionalLight.shadowCameraRight = d;
    directionalLight.shadowCameraTop = d;
    directionalLight.shadowCameraBottom = -d;
    directionalLight.shadowCameraNear = 1;
    directionalLight.shadowCameraFar = 0;
    directionalLight.shadowMapWidth = 800;
    directionalLight.shadowMapHeight = 600;
    directionalLight.shadowBias = -0.005;
    directionalLight.shadowDarkness = 0.15;
  }

  function render() {
    var timer = Date.now() * 0.0005;
    camera.position.setX(Math.cos( timer ) * cameraPositionScalar);
    camera.position.setZ(Math.sin( timer ) * cameraPositionScalar);
    camera.position.setY(85);
    camera.lookAt(new THREE.Vector3(0,0,0));
    camera.updateProjectionMatrix();
    renderer.render( scene, camera );  
  }
})();
  
