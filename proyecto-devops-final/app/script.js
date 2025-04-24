// script.js actualizado y mejorado

let music = document.getElementById('bg-music');
let musicBtn = document.getElementById('music-btn');

let isPlaying = false;

// Intentar reproducir automáticamente al hacer el primer clic en la página
window.addEventListener('DOMContentLoaded', () => {
    document.body.addEventListener('click', () => {
        if (!isPlaying) {
            music.play().catch(err => {
                console.log("Autoplay bloqueado hasta interacción del usuario");
            });
        }
    }, { once: true });
});

musicBtn.addEventListener('click', () => {
    if (!isPlaying) {
        music.play();
        musicBtn.textContent = '⏸ Pausar música';
    } else {
        music.pause();
        musicBtn.textContent = '▶ Reproducir música';
    }
    isPlaying = !isPlaying;
});

// Modal de Registro
const registerBtn = document.getElementById("register-btn");
const loginBtn = document.getElementById("login-btn");
const modal = document.getElementById("authModal");
const closeBtn = document.getElementsByClassName("closeBtn")[0];

if (registerBtn && loginBtn && modal && closeBtn) {
    registerBtn.addEventListener("click", () => {
        modal.style.display = "block";
    });

    loginBtn.addEventListener("click", () => {
        modal.style.display = "block";
    });

    closeBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });

    window.addEventListener("click", (event) => {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    });
}

// Animaciones con Intersection Observer
const fadeInElements = document.querySelectorAll('.race, .contact, footer');

const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.opacity = 1;
      entry.target.style.transform = 'translateY(0)';
    }
  });
}, {
  threshold: 0.1
});

fadeInElements.forEach(el => {
  el.style.opacity = 0;
  el.style.transform = 'translateY(30px)';
  el.style.transition = 'opacity 1s ease, transform 1s ease';
  observer.observe(el);
});
