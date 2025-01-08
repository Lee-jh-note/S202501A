// 검색창에 포커스가 들어가면 placeholder 텍스트를 비움
function clearPlaceholder() {
    var searchInput = document.getElementById('search');
    searchInput.placeholder = '';  // placeholder 비우기
}

// 검색창에서 포커스를 벗어나면 placeholder 텍스트를 다시 설정
function restorePlaceholder() {
    var searchInput = document.getElementById('search');
    if (searchInput.value === '') {  // 입력값이 없으면 원래 텍스트로 복원
        searchInput.placeholder = '필터 메뉴 검색';
    }
}


document.addEventListener('DOMContentLoaded', function () {
    const menuItems = document.querySelectorAll('.menu-item label');
    const submenuItems = document.querySelectorAll('.submenu p');

    // 메뉴 클릭 시 active 클래스 추가/제거
    menuItems.forEach(item => {
        item.addEventListener('click', function () {
            // 모든 메뉴에서 active 클래스를 제거
            menuItems.forEach(menuItem => {
                menuItem.classList.remove('active');
            });
            // 클릭한 메뉴에만 active 클래스 추가
            item.classList.add('active');
        });
    });

    submenuItems.forEach(item => {
        item.addEventListener('click', function () {
            // 서브 메뉴 항목만 진하게
            submenuItems.forEach(submenuItem => {
                submenuItem.classList.remove('active');
            });
            item.classList.add('active');
        });
    });

    // 메뉴가 닫히면 서브 메뉴의 active 클래스를 제거
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            if (!this.checked) {
                const submenu = this.nextElementSibling.nextElementSibling;
                submenu.querySelectorAll('p').forEach(submenuItem => {
                    submenuItem.classList.remove('active');
                });
                // 메뉴 제목도 활성화 상태 제거
                const label = this.nextElementSibling;
                label.classList.remove('active');
            }
        });
    });
});