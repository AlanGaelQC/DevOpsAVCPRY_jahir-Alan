// script.js optimizado para Born to Race

// Control de música
const music = document.getElementById('bg-music');
const musicBtn = document.getElementById('music-btn');
let isPlaying = false;

// Manejo de la reproducción automática
document.addEventListener('DOMContentLoaded', () => {
    // Solución para autoplay bloqueado
    document.body.addEventListener('click', initAudio, { once: true });
    
    // Cargar eventos dinámicos
    loadEvents();
});

function initAudio() {
    music.play()
        .then(() => {
            isPlaying = true;
            musicBtn.textContent = '⏸ Pausar música';
            music.pause(); // Pausamos pero ya está "desbloqueado"
            isPlaying = false;
            musicBtn.textContent = '▶ Reproducir música';
        })
        .catch(err => {
            console.log("Autoplay bloqueado hasta interacción del usuario");
        });
}

// Control del botón de música
musicBtn.addEventListener('click', () => {
    if (music.paused) {
        music.play()
            .then(() => {
                isPlaying = true;
                musicBtn.textContent = '⏸ Pausar música';
            })
            .catch(err => {
                console.error("Error al reproducir:", err);
            });
    } else {
        music.pause();
        isPlaying = false;
        musicBtn.textContent = '▶ Reproducir música';
    }
});

// Modal de Registro
const openModalBtn = document.getElementById('openModalBtn');
const modal = document.getElementById('registerModal');
const closeBtn = document.querySelector('.closeBtn');

if (openModalBtn && modal && closeBtn) {
    openModalBtn.addEventListener('click', () => {
        modal.style.display = 'block';
    });

    closeBtn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
}

// Animaciones con Intersection Observer
const animateElements = () => {
    const elements = document.querySelectorAll('.race, .contact, footer, .hero-content');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate');
            }
        });
    }, {
        threshold: 0.1
    });

    elements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
        observer.observe(el);
    });
};

// Carga de eventos dinámicos
function loadEvents() {
    // Primero cargamos los eventos principales (top-races)
    fetch('http://52.5.101.7:3000/eventos')
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la respuesta del servidor');
            }
            return response.json();
        })
        .then(events => {
            const topRaces = document.querySelector('.top-races');
            const bottomRaces = document.querySelector('.bottom-races');
            
            // Limpiamos solo si vamos a cargar dinámicamente
            // topRaces.innerHTML = '';
            // bottomRaces.innerHTML = '';
            
            // Podrías usar esto si quieres cargar los eventos dinámicamente
            // events.slice(0, 4).forEach(event => {
            //     topRaces.appendChild(createRaceCard(event));
            // });
            
            // events.slice(4, 7).forEach(event => {
            //     bottomRaces.appendChild(createRaceCard(event));
            // });
        })
        .catch(error => {
            console.error('Error cargando eventos:', error);
            // Muestra un mensaje de error si lo deseas
        });

    // Iniciamos animaciones
    animateElements();
}

// Función para crear tarjetas de carrera (opcional)
function createRaceCard(event) {
    const raceDiv = document.createElement('div');
    raceDiv.className = 'race';
    
    const raceImage = document.createElement('img');
    raceImage.src = event.imagen_url || 'imagenes/default-race.jpg';
    raceImage.alt = event.nombre;
    raceImage.loading = 'lazy';

    const raceTitle = document.createElement('h2');
    raceTitle.textContent = event.nombre;

    const raceDesc = document.createElement('p');
    raceDesc.textContent = event.descripcion;

    raceDiv.appendChild(raceImage);
    raceDiv.appendChild(raceTitle);
    raceDiv.appendChild(raceDesc);

    return raceDiv;
}

// Manejo de errores global
window.addEventListener('error', (e) => {
    console.error('Error capturado:', e.message);
    // Podrías mostrar una notificación al usuario
});