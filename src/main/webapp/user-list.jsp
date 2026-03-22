<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Users</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<header class="masthead">
    <div class="site-title"></div>
    <nav class="masthead-nav">
        <a href="<%=request.getContextPath()%>/list" class="nav-item active">Utilisateurs</a>
        <a href="<%=request.getContextPath()%>/new" class="nav-item">Ajouter</a>
    </nav>
</header>

<div class="wrapper">

    <div class="section-rule">
        <span class="section-label">Registre</span>
        <h1 class="section-title">Liste des utilisateurs</h1>
        <span class="section-count">
            <c:out value="${listUser.size()}" /> enregistrement(s)
        </span>
    </div>

    <div class="toolbar">
        <a href="<%=request.getContextPath()%>/new" class="btn-add">Nouvel utilisateur</a>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>N ID</th>
                    <th>Nom</th>
                    <th>Prenom</th>
                    <th>Login</th>
                    <th>Password</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty listUser}">
                        <tr>
                            <td colspan="6">
                                <div class="empty">
                                    <div class="empty-headline">Aucun utilisateur enregistre.</div>
                                    <a href="<%=request.getContextPath()%>/new" class="empty-link">
                                        Creer le premier
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="user" items="${listUser}">
                            <tr>
                                <td class="td-id"><c:out value="${user.id}" /></td>
                                <td class="td-name"><c:out value="${user.nom}" /></td>
                                <td class="td-name"><c:out value="${user.prenom}" /></td>
                                <td class="td-login"><c:out value="${user.login}" /></td>
                                <td><span class="password-mask">........</span></td>
                                <td class="td-actions">
                                    <div class="actions">
                                        <a href="edit?id=<c:out value='${user.id}'/>" class="btn-edit">Modifier</a>
                                       <a href="#" class="btn-delete"
  										 onclick="openPopup('delete?id=<c:out value='${user.id}'/>'); return false;">Supprimer</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    
    <div class="footer-rule">
   		 <span class="footer-text">M2GLSI &copy; 2026</span>
	</div>
	<!-- POPUP SUPPRESSION -->
	<div class="overlay hidden" id="deleteOverlay">
	    <div class="popup">
	        <span class="popup-label">Attention</span>
	        <div class="popup-title">Supprimer l'utilisateur ?</div>
	        <div class="popup-subtitle">Cette action est irreversible.</div>
	        <div class="popup-actions">
	            <a href="#" id="confirmDelete" class="popup-confirm">Supprimer</a>
	            <button onclick="closePopup()" class="popup-cancel">Annuler</button>
	        </div>
	    </div>
	</div>
	<!-- TOAST -->
	<c:if test="${param.success == 'insert'}">
	    <div class="toast" id="toast">Utilisateur cree avec succes</div>
	</c:if>
	<c:if test="${param.success == 'update'}">
	    <div class="toast" id="toast">Utilisateur modifie avec succes</div>
	</c:if>
	<c:if test="${param.success == 'delete'}">
	    <div class="toast" id="toast">Utilisateur supprime avec succes</div>
	</c:if>
</div>
<script>
    function openPopup(url) {
        document.getElementById('confirmDelete').href = url;
        document.getElementById('deleteOverlay').classList.remove('hidden');
    }

    function closePopup() {
        document.getElementById('deleteOverlay').classList.add('hidden');
    }

    // Auto-hide toast after 3.5s
    var toast = document.getElementById('toast');
    if (toast) {
        setTimeout(function() {
            toast.remove();
        }, 3500);
    }
</script>
</body>
</html>
