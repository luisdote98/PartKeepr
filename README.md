# PartKeepr (Active Fork by Luis González Dote)

> ⚡️ A maintained and enhanced fork of the original [PartKeepr](https://github.com/partkeepr/PartKeepr) open-source inventory management system.

This fork is aimed at reviving and extending the functionality of PartKeepr, after the original project was archived by its creator. It introduces new features, UI enhancements, and backend improvements while keeping compatibility with existing installations.

---

## 🚀 What's New in This Fork

This version includes multiple improvements, developed and integrated by [Luis González Dote](mailto:luisindote@gmail.com):

### 1. 🔐 Permissions System
- Role-based control: only authorized users can create/delete components or users.
- Real-time interface blocking with error messages for unauthorized actions.

### 2. 👤 Enhanced User Profile
- New user fields: phone number and profile photo.
- Upload, resize, and delete profile images.
- Default avatar support.

### 3. 🖼️ Attachment Thumbnails
- Inline thumbnails in the attachments grid.
- Improves usability by avoiding file opening for preview.

### 4. 🧭 Category Search
- New API endpoint for category search.
- Search bar with live filtering inside the category tree.

### 5. ✏️ Inline Editing
- Quick inline editing of key numeric fields (stock and average price).
- Permission validation included.

### 6. 🔍 Improved Component Search
- Search terms are now **highlighted in yellow** instead of filtering rows.
- Enhances visibility of results.

### 7. 📦 Sub-Location Uniqueness Logic
- Allows sub-locations with the same name under different parents.
- Database uniqueness adjusted to consider context.

### 8. 🔗 Nexar / OctoPart Integration
- New Nexar API integration to fetch:
  - Distributors
  - Datasheets
  - Prices and offers
  - Descriptions and product images

---

## 📦 Installation

> Instructions to install this fork will be provided soon (Docker version + guide included in the TFG file).

---

## 🔧 Technologies

- PHP
- Symfony 2.8
- ExtJS
- Nexar API
- MySQL / PostgreSQL

---

## 📘 Acknowledgements

This project is a fork of the original [PartKeepr](https://github.com/partkeepr/PartKeepr), created by **Felicia Hummel ([@Drachenkaetzchen](https://github.com/Drachenkaetzchen))**, who gracefully open-sourced and maintained it for years.

---

## 🛠️ Maintainer

- Luis González Dote  
- GitHub: [luisdote98](https://github.com/luisdote98)

---

## 📜 License

This fork remains under the **GPLv3 License**, in compliance with the original repository.
