//= require three.js
//= require Detector.js
//= require STLLoader.js
//= require stats.min.js

(function() {
  if ( ! Detector.webgl ) Detector.addGetWebGLMessage();
  
  var stats;
  var geometry, camera, center, scene, renderer, mesh, cameraPositionScalar;
  var susaning = true;
  var targetRotationX = 0;
  var targetRotationY = 0.5;
  var targetRotationXOnMouseDown = 0;
  var targetRotationYOnMouseDown = 0;

  var curRotationX = targetRotationX;
  var curRotationY = targetRotationY;
  var lastTimer = 0;

  var mouseDown = false;
  var mouseX = 0;
  var mouseY = 0;
  var mouseXOnMouseDown = 0;
  var mouseYOnMouseDown = 0;
  
  init_stl_previewer = function(stl_file_name) {
    $('.stl-preview').empty();
    $('.stl-preview').height(300);
    $('.stl-preview').css('padding', '10px');
    camera = new THREE.PerspectiveCamera( 20, $('.stl-preview').width() / $('.stl-preview').height(), 1, 1000 );
    scene = new THREE.Scene();
    center =  new THREE.Vector3(0,0,0);
    cameraPositionScalar = 500;
    
    var material = new THREE.MeshPhongMaterial( { ambient: 0x1441ff, color: 0x1441ff, specular: 0x909090, shininess: 20 } );
    var printbox_geo = new THREE.CubeGeometry(190, 100, 200);
    printbox_geo.applyMatrix((new THREE.Matrix4()).makeTranslation(0, 50, 0));
    var printbox = new THREE.Mesh(printbox_geo, new THREE.MeshBasicMaterial({ wireframe: 1, color: 0x444444, wireframeLinewidth: 2 })); 
    scene.add( printbox );

    var basegrid_geo = new THREE.PlaneGeometry(190, 200, 19, 20);
    basegrid_geo.applyMatrix((new THREE.Matrix4()).makeRotationX(-Math.PI/2));
    var basegrid = new THREE.Mesh(basegrid_geo, new THREE.MeshBasicMaterial({ wireframe: 1, color: 0xaaaaaa }));
    scene.add( basegrid );
    
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
    
    scene.add( new THREE.AmbientLight( 0x606060 ) );
    addShadowedLight( 1, 1, 1, 0xffffff, 1.35 );
    addShadowedLight( 0.5, 1, -1, 0xffffff, 1 );
    
    renderer = new THREE.WebGLRenderer( { antialias: true, alpha: false, clearColor: 0xffffff } );
    renderer.setSize( $('.stl-preview').width(), $('.stl-preview').height() );
    
    renderer.gammaInput = true;
    renderer.gammaOutput = true;
    renderer.physicallyBasedShading = true;
    
    renderer.shadowMapEnabled = true;
    renderer.shadowMapCullFace = THREE.CullFaceBack;
    
    $('.stl-preview').append( renderer.domElement );
    $('.stl-preview').mousedown( onPreviewMouseDown );
    $(document).mousemove( onPreviewMouseMove );
    $(document).mouseup( onPreviewMouseUp );
    
    stats = new Stats();
    stats.domElement.style.position = 'absolute';
    stats.domElement.style.top = '0px';
    // statistics about the previewer
    // container.appendChild( stats.domElement );

    animate();
  }

  function onPreviewMouseDown( event ) {

    event.preventDefault();

    mouseXOnMouseDown = mouseX = event.clientX;
    mouseYOnMouseDown = mouseY = event.clientY;

    susaning = false;
    targetRotationXOnMouseDown = targetRotationX;
    targetRotationYOnMouseDown = targetRotationY;
    mouseDown = true;

  }

  function onPreviewMouseMove( event ) {

    if( mouseDown ) {

      mouseX = event.clientX;
      mouseY = event.clientY;

      targetRotationX = targetRotationXOnMouseDown + ( mouseX - mouseXOnMouseDown ) * 0.009;
      targetRotationY = Math.min(1.5, Math.max(-1.4, targetRotationYOnMouseDown + ( mouseY - mouseYOnMouseDown ) * 0.009));

    }

  }

  function onPreviewMouseUp( event ) {

    mouseDown = false;

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
    if( lastTimer == 0 ) {
        lastTimer = Date.now();
    }
    if( susaning ) {
        targetRotationX += (Date.now() - lastTimer) * 0.0005;
        lastTimer = Date.now();
    }

    curRotationX += ( targetRotationX - curRotationX ) * 0.07;
    curRotationY += ( targetRotationY - curRotationY ) * 0.07;

    camera.position.setX(Math.cos( curRotationY ) * Math.cos( curRotationX ) * cameraPositionScalar);
    camera.position.setZ(Math.cos( curRotationY ) * Math.sin( curRotationX ) * cameraPositionScalar);
    camera.position.setY(Math.sin( curRotationY ) * cameraPositionScalar );
    camera.lookAt(new THREE.Vector3(0, 25, 0));
    camera.updateProjectionMatrix();
    renderer.render( scene, camera );  
  }
})();
  
