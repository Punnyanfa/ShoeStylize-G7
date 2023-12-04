<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="purchases-table-all" class="stripe">
    <thead>
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th>Items</th>
        <th>Contacts</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${LIST_ALL_ORDERS}" var="Order">
        <tr>
            <td>${Order.getId()}</td>
            <td><img class="order-img" src="${Order.getShoe().getImageLink()}"></td>
            <td>
                <p class="order-date"><b>Date: </b>${Order.getFormatDate()}</p>
                <div>
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>Item</th>
                            <th>Value</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${Order.getShoe().getTitle()}</td>
                            <td>$${Order.getShoe().getPrice()}</td>
                        </tr>
                        <c:forEach items="${Order.getExtras()}" var="Extra">
                            <tr>
                                <td>
                                        ${Extra.getTitle()}
                                </td>
                                <td>$${Extra.getPrice()}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td>Shipping fee</td>
                            <td>$2.5</td>
                        </tr>
                        <tr>
                            <td><b>Grand total</b></td>
                            <td class="order--price">$${Order.getTotalPrice()}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <c:if test="${Order.getServiceProviderNote() != null && !Order.getServiceProviderNote().isEmpty()}">
                    <div class="order-note-noti">
                        <b>Note from service provider:</b>
                        <p>${Order.getServiceProviderNote()}</p>
                    </div>
                </c:if>
            </td>
            <td>
                <div>
                    <h6>Address:</h6>
                    <p>${Order.getAddress1()}</p>
                    <p>${Order.getAddress2()}</p>
                </div>
                <hr>
                <div>
                    <h6>Phone:</h6>
                    <p>${Order.getPhone1()}</p>
                    <p>${Order.getPhone2()}</p>
                </div>
                <hr>
                <div>
                    <h6>Your note:</h6>
                    <p>${Order.getCustomerNote()}</p>
                </div>
            </td>
            <td>
                <c:choose>
                    <c:when test="${Order.getOrderShoeStatus() == 'pending'}">
                        <p class="order-tag" style="background-color: #adadad">Processing</p>
                    </c:when>
                    <c:when test="${Order.getOrderShoeStatus() == 'in_progress'}">
                        <p class="order-tag" style="background-color: #083dea">In progress</p>
                    </c:when>
                    <c:when test="${Order.getOrderShoeStatus() == 'cancelled'}">
                        <p class="order-tag" style="background-color: #e50000">Cancelled</p>
                    </c:when>
                    <c:when test="${Order.getOrderShoeStatus() == 'success'}">
                        <p class="order-tag" style="background-color: #00b711">Completed</p>
                    </c:when>
                </c:choose>
            </td>
            <td>
                <div>
                    <button type="button" class="btn btn-wide btn-preview btn-primary"
                            data-id="${Order.getId()}"
                            data-textureData='${Order.getTextureData()}'
                            data-texture='${pageContext.request.contextPath}/api/order-texture?id=${Order.getId()}'
                    >
                        Check design
                    </button>
                </div>
                <c:if test="${Order.getOrderShoeStatus() != 'cancelled' && Order.getOrderShoeStatus() != 'success'}">
                    <div>
                        <button type="button" class="btn btn-wide btn-danger" data-bs-toggle="modal"
                                data-bs-target="#modal-all-cancel-${Order.getId()}">
                            Cancel
                        </button>

                        <div class="modal fade" id="modal-all-cancel-${Order.getId()}" tabindex="-1"
                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Cancel order</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h5>Hold up!</h5>
                                        <p>Are you sure you want to cancel this order</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                        </button>
                                        <form method="POST"
                                              action="${pageContext.request.contextPath}/api/order-edit/cancel">
                                            <input type="hidden" name="id" value="${Order.getId()}">
                                            <input type="submit" class="btn btn-danger" value="Yes, cancel my order">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>