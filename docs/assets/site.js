(function () {
  var root = document.documentElement;
  var stored = window.localStorage.getItem("rmguard-theme");

  if (stored === "light" || stored === "dark") {
    root.setAttribute("data-theme", stored);
  }

  function currentTheme() {
    var explicit = root.getAttribute("data-theme");
    if (explicit) {
      return explicit;
    }
    return window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
  }

  function syncButton(button) {
    var theme = currentTheme();
    button.textContent = theme === "dark" ? "Light" : "Dark";
    button.setAttribute("aria-label", "Switch to " + (theme === "dark" ? "light" : "dark") + " mode");
  }

  window.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("[data-theme-toggle]").forEach(function (button) {
      syncButton(button);
      button.addEventListener("click", function () {
        var next = currentTheme() === "dark" ? "light" : "dark";
        root.setAttribute("data-theme", next);
        window.localStorage.setItem("rmguard-theme", next);
        syncButton(button);
      });
    });
  });
})();
