function showCarousel(imageUrls) {
  var carouselContainer = document.getElementById('carouselContainer');

  // Limpiar cualquier contenido previo
  carouselContainer.innerHTML = '';

  var carouselInner = document.createElement('div');
  carouselInner.className = 'carousel-container';

  imageUrls.forEach((url, index) => {
    var carouselSlide = document.createElement('div');
    carouselSlide.className = 'carousel-slide' + (index === 0 ? ' active' : '');

    var img = document.createElement('img');
    img.src = url;
    img.alt = 'Image ' + (index + 1);

    carouselSlide.appendChild(img);
    carouselInner.appendChild(carouselSlide);
  });

  var prev = document.createElement('a');
  prev.className = 'carousel-control-prev';
  prev.innerHTML = '&#10094;';
  prev.onclick = function() { changeSlide(-1); };

  var next = document.createElement('a');
  next.className = 'carousel-control-next';
  next.innerHTML = '&#10095;';
  next.onclick = function() { changeSlide(1); };

  carouselInner.appendChild(prev);
  carouselInner.appendChild(next);

  carouselContainer.appendChild(carouselInner);

  var currentSlide = 0;

  function changeSlide(n) {
    var slides = document.getElementsByClassName('carousel-slide');
    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + n + slides.length) % slides.length;
    slides[currentSlide].classList.add('active');
  }
}