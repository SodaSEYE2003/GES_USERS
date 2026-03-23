<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Connexion</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>



<div class="wrapper-form">

    <form action="login" method="post">

        <div class="form-header">
            <span class="form-mode">Authentification</span>
            <div class="form-title">Bon <em>retour</em></div>
            <div class="form-subtitle">Connectez-vous pour acceder a l application.</div>
        </div>

        <!-- Message d'erreur -->
        <c:if test="${error != null}">
            <div class="error-msg">
                <c:out value="${error}" />
            </div>
        </c:if>

        <div class="field">
            <label class="field-label">Login</label>
            <input type="text" name="login" class="field-input"
                placeholder="Ex: amadou.diallo"
                required />
        </div>

        <div class="field">
            <label class="field-label">Mot de passe</label>
            <input type="password" name="password" class="field-input"
                placeholder="........"
                required />
        </div>

        <div class="btn-group">
            <button type="submit" class="btn-submit">Se connecter</button>
        </div>

    </form>

    <div class="footer-rule">
        <span class="footer-text">M2GLSI &copy; 2026</span>
    </div>

</div>

</body>
</html>