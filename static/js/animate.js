document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.copy-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const id = btn.dataset.target;
      const text = document.getElementById(id).innerText;
      navigator.clipboard.writeText(text).then(() => {
        btn.classList.add('pulse');
        setTimeout(() => btn.classList.remove('pulse'), 400);
      });
    });
  });

  document.getElementById('generate-btn').addEventListener('click', () => {
    setTimeout(() => window.location.reload(), 150);
  });
});
