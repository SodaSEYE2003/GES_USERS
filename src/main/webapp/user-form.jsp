<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Formulaire</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<header class="masthead">
    <div class="site-title"></div>
    <nav class="masthead-nav">
        <a href="<%=request.getContextPath()%>/list" class="nav-item">Utilisateurs</a>
        <a href="<%=request.getContextPath()%>/new" class="nav-item active">Ajouter</a>
    </nav>
</header>

<div class="wrapper-form">

    <c:if test="${user != null}">
        <form action="update" method="post">
    </c:if>
    <c:if test="${user == null}">
        <form action="insert" method="post">
    </c:if>

    <div class="form-header">
        <span class="form-mode">
            <c:if test="${user != null}">Modification</c:if>
            <c:if test="${user == null}">Creation</c:if>
        </span>
        <div class="form-title">
            <c:if test="${user != null}">Modifier <em>l utilisateur</em></c:if>
            <c:if test="${user == null}">Nouvel <em>utilisateur</em></c:if>
        </div>
        <div class="form-subtitle">
            <c:if test="${user != null}">Mettez a jour les informations ci-dessous puis enregistrez.</c:if>
            <c:if test="${user == null}">Remplissez les champs pour creer un nouveau compte.</c:if>
        </div>
    </div>

    <c:if test="${user != null}">
        <input type="hidden" name="id" value="<c:out value='${user.id}' />" />
    </c:if>

    <div class="fields-grid">
        <div class="field">
            <label class="field-label">Nom</label>
            <input type="text" name="nom" class="field-input"
                value="<c:out value='${user.nom}' />"
                placeholder="Ex: Diallo"
                required />
        </div>
        <div class="field">
            <label class="field-label">Prenom</label>
            <input type="text" name="prenom" class="field-input"
                value="<c:out value='${user.prenom}' />"
                placeholder="Ex: Amadou"
                 required  />
        </div>
    </div>

    <div class="field">
        <label class="field-label">Login</label>
        <input type="text" name="login" class="field-input"
            value="<c:out value='${user.login}' />"
            placeholder="Ex: amadou.diallo" 
             required />
    </div>

    <div class="field">
        <label class="field-label">Mot de passe</label>
        <input type="password" name="password" class="field-input"
            value="<c:out value='${user.password}' />"
            placeholder="........" 
             required />
    </div>

    <div class="btn-group">
        <button type="submit" class="btn-submit">
            <c:if test="${user != null}">Enregistrer</c:if>
            <c:if test="${user == null}">Creer l utilisateur</c:if>
        </button>
        <a href="<%=request.getContextPath()%>/list" class="btn-list">Retour a la liste</a>
    </div>

    </form>

    <div class="footer-rule">
   		 <span class="footer-text">M2GLSI &copy; 2026</span>
	</div>

</div>

</body>
</html>
