import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

document.addEventListener('DOMContentLoaded', function() {
  const calendarEl = document.getElementById('calendar');
  if (calendarEl) {
    const calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
      initialView: 'dayGridMonth',
      locale: "jp",
      height: 400, // 高さ調整
    });
    calendar.render();
  }
});